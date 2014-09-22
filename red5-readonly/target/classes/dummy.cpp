#include <stdio.h>
#include <stdlib.h>
#include <execinfo.h>
#include <sys/signal.h>
#include <time.h>
#include <errno.h>
#include <sys/stat.h>
#include <string.h>
#include <fcntl.h>    /* For O_RDWR */
#include <unistd.h>   /* For open(), creat() */
#include <string>
#include <assert.h>
#include "Output.h"

using namespace std;

#define TEST_STREAM_ID  1 // test ID for dummy testingx
#define MAX_XCODING_INSTANCES 32
#define MIN(a, b) a<b?a:b

void handlesig( int signum )
{
    OUTPUT("Exiting on signal: %d\r\n", signum );
    exit( 0 );
}

bool doRead( int fd, char *buf, size_t len ) {
    size_t bytesRead = 0;
    
    while ( bytesRead < len ) {
        size_t bytesToRead = len - bytesRead;
        int t = read( fd, buf + bytesRead, bytesToRead );
        if ( t <= 0 ) {
            OUTPUT("read() failed: %s\r\n", strerror(errno) );
                        
            return false;
        }
        bytesRead += t;
    }
    
    return true;
}

bool doWrite( int fd, const char *buf, size_t len ) {
    size_t bytesWrote = 0;
    
    while ( bytesWrote < len ) {
        size_t bytesToWrite = len - bytesWrote;
        int t = write( fd, buf + bytesWrote, bytesToWrite );
        if ( t <= 0 ) {
            OUTPUT("write() failed: %s \r\n", strerror(errno) );
            return false;
        }
        
        bytesWrote += t;
    }
    
    return true;
}

unsigned int count_bits(unsigned int n) {     
    unsigned int c; // c accumulates the total bits set in v
    for (c = 0; n; c++) { 
        n &= n - 1; // clear the least significant bit set
    }
    return c;
}
typedef enum FLVSegmentParsingState {
    SEARCHING_SEGHEADER,
    SEARCHING_STREAM_MASK,
    SEARCHING_STREAM_HEADER,
    SEARCHING_STREAM_DATA
}FLVSegmentParsingState;

FLVSegmentParsingState parsingState_;
string curBuf_;
unsigned int curSegTagSize_;
unsigned int curStreamId_;
unsigned int curStreamLen_;
unsigned int curStreamCnt_;
unsigned int numStreams_;

void writeData(unsigned char* buf, int len);
bool readData(unsigned char* data, unsigned int len) {
    while( len ) {
        switch( parsingState_ ) {
        case SEARCHING_SEGHEADER:
            {
                if ( curBuf_.size() < 4 ) {
                    size_t cpLen = MIN(len, 4-curBuf_.size());
                    curBuf_ += string((const char*)data, cpLen); //concatenate the string                                                                                                                 
                    len -= cpLen;
                    data += cpLen;
                }

                if ( curBuf_.size() >= 4 ) {
                    assert(curBuf_[0] == 'S' && curBuf_[1] == 'G' && curBuf_[2] == 'I');
                    assert(curBuf_[3] == 0); //even layout for now
                    curBuf_.clear();
                    curSegTagSize_ = 0;
                    parsingState_ = SEARCHING_STREAM_MASK;
                }
                break;
            }
        case SEARCHING_STREAM_MASK:
            {
                if ( curBuf_.size() < 4 ) {
                    size_t cpLen = MIN(len, 4-curBuf_.size());
                    curBuf_ += string((const char*)data, cpLen); //concatenate the string                                                                                                          

                    len -= cpLen;
                    data += cpLen;
                }

                if ( curBuf_.size() >= 4 ) {
                    unsigned int streamMask;
                    memcpy(&streamMask, curBuf_.data(), sizeof(unsigned int));
                    
                    //handle mask here 
                    numStreams_ = count_bits(streamMask);
                    //printf( "---streamMask=0x%x\r\n", streamMask);
                    //printf( "---numStreams_=%d\r\n", numStreams_);

                    int index = 0;
                    while( index < (int)MAX_XCODING_INSTANCES ) {
                        unsigned int value = ((streamMask<<31)>>31); //mask off all other bits
                        streamMask >>= 1; //shift 1 bit
                        index++;
                    }

                    curStreamCnt_ = numStreams_;
                    curBuf_.clear();
                    curSegTagSize_ = 0;
                    parsingState_ = SEARCHING_STREAM_HEADER;
                }
                break;
            }
        case SEARCHING_STREAM_HEADER:
            {
                if ( curBuf_.size() < 6 ) {
                    size_t cpLen = MIN(len, 6-curBuf_.size());
                    curBuf_ += string((const char*)data, cpLen); //concatenate the string

                    len -= cpLen;
                    data += cpLen;
                }
                if ( curBuf_.size() >= 6 ) {
                    curStreamId_ = (curBuf_[0]&0xf8)>>3; //first 5 bits
                    assert(curStreamId_ < (unsigned int)MAX_XCODING_INSTANCES);

                    unsigned int curStreamSource = (curBuf_[0]&0x7); //last 3 bits
                    assert(curBuf_[1] == 0x0); //ignore the special property

                    memcpy(&curStreamLen_, curBuf_.data()+2, 4); //read the len
                    //OUTPUT("---curStreamCnt_=%d, curBuf_[0]=0x%x, curStreamId_=%d curStreamSource=%d, curStreamLen_=%d\r\n", curStreamCnt_, curBuf_[0], curStreamId_, curStreamSource, curStreamLen_);

                    curBuf_.clear();
                    curSegTagSize_ = 0;
                    parsingState_ = SEARCHING_STREAM_DATA;
                }
                break;
            }
        case SEARCHING_STREAM_DATA:
            {
                bool bIsFinished = false;
                if ( curStreamLen_ ) {
                    if ( curBuf_.size() < curStreamLen_ ) {
                        size_t cpLen = MIN(len, curStreamLen_-curBuf_.size());
                        curBuf_ += string((const char*)data, cpLen); //concatenate the string     
                        
                        len -= cpLen;
                        data += cpLen;
                    }
                    if ( curBuf_.size() >= curStreamLen_ ) {
                        //OUTPUT( "---curStreamId_=%d curStreamLen_=%d\r\n", curStreamId_, curStreamLen_);
                        //TODO only save the first video
                        if( curStreamId_ == TEST_STREAM_ID ) {
                            writeData( (unsigned char*)curBuf_.data(), curStreamLen_ );
                        }
                        bIsFinished = true;
                    }
                } else {
                    //0 bytes means no data received for this channel even though it's active
                    bIsFinished = true;
                }
                if( bIsFinished ) {
                    curBuf_.clear();
                    curSegTagSize_ = 0;
                    curStreamCnt_--;
                    if ( curStreamCnt_ ) {
                        parsingState_ = SEARCHING_STREAM_HEADER;
                    } else {
                        parsingState_ = SEARCHING_SEGHEADER;
                    }
                }

                break;
            }
        }
    }
    return true;
}

void writeData(unsigned char* buf, int len) {
    unsigned int streamMask = 1<<TEST_STREAM_ID; 
    int totalStreams = 2; //this stream + all-in-one stream
    if( len > 0 ) {             
        //Headers
        //  Meta data = 3 bytes //starting with SGO //segment output
        //  StreamMask = 4 byte //max of 32 output streams
        // Content * (NoOfStreams+1): //MAX_ID is the all-mixed stream, 1-NoOfStreams are for each mobile stream
        //  streamId = 1 byte
        //  LengthOfStream = 4 bytes
        //  StreamData = n bytes
        int totalLen = 7 + 5*totalStreams + len;
        unsigned char* data = (unsigned char*)malloc( totalLen );
        data[0] = 'S';
        data[1] = 'G';
        data[2] = 'O';
        memcpy(data+3, &streamMask, sizeof(streamMask));
        int offset = 7;
        OUTPUT("------dummy writeData streamId=%d, dataLen=%d\r\n", TEST_STREAM_ID, len);
        unsigned char streamIdByte = TEST_STREAM_ID;
        memcpy(data+offset, &streamIdByte, sizeof(unsigned char));
        offset += sizeof(unsigned char);
        memcpy(data+offset, &len, sizeof(unsigned int));
        offset += sizeof(unsigned int);
        memcpy(data+offset, buf, len);
        offset += len;
        
        //an empty all-in-one stream 
        streamIdByte = 32;
        memcpy(data+offset, &streamIdByte, sizeof(unsigned char));
        offset += sizeof(unsigned char);
        len = 0;
        memcpy(data+offset, &len, sizeof(unsigned int));
        offset += sizeof(unsigned int);

        //write to stdout
        assert(totalLen == offset);
        doWrite( 1, (const char*)data, totalLen);

        free(data);
    }
}

#define BUF_SIZE 100
//test example to read input, parse the SGI data and write SGO data immediately
int main()
{
    signal( SIGSEGV, handlesig );
    signal( SIGFPE, handlesig );
    signal( SIGBUS, handlesig );
    signal( SIGSYS, handlesig );

    char buf[BUF_SIZE]; 
    const char header[13] = {0x46,0x4c,0x56,0x01,0x05, //5 bytes flv + type
                             0x00,0x00,0x00,0x09, //length = 9
                             0x00,0x00,0x00,0x00}; //prev len = 0
    bool bWorking = true;
    bool bIsStarted = false;

    Logger::initLog("dummyProc", true);

    OUTPUT("------dummy started=%d\r\n");
    while( bWorking ) {
        bWorking = doRead( 0, buf, BUF_SIZE );
        if ( bWorking ){
            if(!bIsStarted) {
                //write flv header
                bIsStarted = true;
                writeData( (unsigned char*)header, 13);
            }
            OUTPUT("------dummy read data, size=%d\r\n", BUF_SIZE);
            readData((unsigned char*)buf, BUF_SIZE);
        }
    }

    OUTPUT("------dummy ended=%d\r\n");

    return 0;
}
