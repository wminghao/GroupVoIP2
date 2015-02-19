#include <stdio.h> 
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include "flvrealtimeparser.h"

static const unsigned int FLV_START_POS = 13;

bool doWrite( int fd, const void *buf, size_t len ) {
  size_t bytesWrote = 0;
    
  while ( bytesWrote < len ) {
    size_t bytesToWrite = len - bytesWrote;
    if ( bytesToWrite > 41920 ) bytesToWrite = 41920;
        
    int t = write( fd, (const char *)buf + bytesWrote, bytesToWrite );
    if ( t <= 0 ) {
      return false;
    }
        
    bytesWrote += t;
  }
  
  return true;
}

long runTest(FILE* fd1, FILE* fd2, FILE* fd3, FILE* fd4, FILE* fd5)
{
    unsigned char bigBuf[MAX_BUFFER_SIZE];
    int totalLen = 0;
    int bufLen = 0;
    bool bFile1Done = false;
    bool bFile2Done = false;
    bool bFile3Done = false;
    bool bFile4Done = false;
    bool bFile5Done = false;
    FLVRealTimeParser realtimeParser1;
    FLVRealTimeParser realtimeParser2;
    FLVRealTimeParser realtimeParser3;
    FLVRealTimeParser realtimeParser4;
    FLVRealTimeParser realtimeParser5;
    unsigned char* result = NULL;
    while(!(bFile1Done && bFile2Done && bFile3Done && bFile4Done & bFile5Done)) {
        unsigned char* buffer = bigBuf;
        totalLen = 0;

        //first send the segHeader
        unsigned char metaData []= {'S', 'G', 'I', 0x0}; //even layout
        memcpy(buffer, metaData, sizeof(metaData));
        unsigned int mask5Stream = 0x1f;
        if( bFile1Done ) {
            mask5Stream &= 0xfe;
        } 
        if ( bFile2Done ) {
            mask5Stream &= 0xfd;
        } 
        if( bFile3Done ) {
            mask5Stream &= 0xfb;
        }
        if ( bFile4Done ) {
            mask5Stream &= 0xf7;
        }
        if ( bFile5Done ) {
            mask5Stream &= 0xef;
        }
        memcpy(buffer+sizeof(metaData), &mask5Stream, sizeof(unsigned int));
        buffer += (sizeof(metaData)+sizeof(unsigned int));
        totalLen += (sizeof(metaData)+sizeof(unsigned int));

        if ( !bFile1Done ) {
            //then send the stream heaer of stream 1
            result = realtimeParser1.readData(fd1, &bufLen);
            if ( result ) {
            //unsigned char streamIdSource[] = {0x01, 0x0}; //desktop stream
                unsigned char streamIdSource[] = {0x02, 0x0}; //mobile stream
                memcpy(buffer, &streamIdSource, sizeof(streamIdSource));
                memcpy(buffer+sizeof(streamIdSource), &bufLen, sizeof(unsigned int));
                memcpy((char*)buffer+sizeof(streamIdSource)+sizeof(unsigned int), result, bufLen);
                buffer += (sizeof(streamIdSource)+sizeof(unsigned int)+bufLen);
                totalLen += (sizeof(streamIdSource)+sizeof(unsigned int)+bufLen);
            } else {
                //fix the mask byte
                mask5Stream &= 0xfe;
                memcpy(bigBuf+sizeof(metaData), &mask5Stream, sizeof(unsigned int));
                bFile1Done = true;
                fprintf(stderr,"==file 1 done\r\n");
            }
        }

        if ( !bFile2Done ) {
            //then send the stream heaer of stream 2
            result = realtimeParser2.readData(fd2, &bufLen);
            if ( result ) {
                unsigned char streamIdSource[] = {0x0a, 0x0}; //mobile stream
                memcpy(buffer, &streamIdSource, sizeof(streamIdSource));
                memcpy(buffer+sizeof(streamIdSource), &bufLen, sizeof(unsigned int));
                memcpy((char*)buffer+sizeof(streamIdSource)+sizeof(unsigned int), result, bufLen);
                buffer += (sizeof(streamIdSource)+sizeof(unsigned int)+bufLen);
                totalLen += (sizeof(streamIdSource)+sizeof(unsigned int)+bufLen);
            } else {
                //fix the mask byte
                mask5Stream &= 0xfd;
                memcpy(bigBuf+sizeof(metaData), &mask5Stream, sizeof(unsigned int));
                bFile2Done = true;
                fprintf(stderr,"==file 2 done\r\n");
            }
        }

        if ( !bFile3Done ) {
            //then send the stream heaer of stream 3
            result = realtimeParser3.readData(fd3, &bufLen);
            if ( result ) {
                //then send the stream heaer of stream 3
                unsigned char streamIdSource[] = {0x11, 0x0};//desktop stream
                memcpy(buffer, &streamIdSource, sizeof(streamIdSource));
                memcpy(buffer+sizeof(streamIdSource), &bufLen, sizeof(unsigned int));
                
                memcpy((char*)buffer+sizeof(streamIdSource)+sizeof(unsigned int), result, bufLen);
                buffer += (sizeof(streamIdSource)+sizeof(unsigned int)+bufLen);
                totalLen += (sizeof(streamIdSource)+sizeof(unsigned int)+bufLen);
            } else {
                //fix the mask byte
                mask5Stream &= 0xfb;
                memcpy(bigBuf+sizeof(metaData), &mask5Stream, sizeof(unsigned int));
                bFile3Done = true;
                fprintf(stderr,"==file 3 done\r\n");
            }
        }

        if ( !bFile4Done ) {
            //then send the stream heaer of stream 4
            result = realtimeParser4.readData(fd4, &bufLen);
            if ( result ) {
                //then send the stream heaer of stream 4
                unsigned char streamIdSource[] = {0x1a, 0x0};//mobile stream
                memcpy(buffer, &streamIdSource, sizeof(streamIdSource));
                memcpy(buffer+sizeof(streamIdSource), &bufLen, sizeof(unsigned int));
                memcpy((char*)buffer+sizeof(streamIdSource)+sizeof(unsigned int), result, bufLen);
                buffer += (sizeof(streamIdSource)+sizeof(unsigned int)+bufLen);
                totalLen += (sizeof(streamIdSource)+sizeof(unsigned int)+bufLen);
            } else {
                //fix the mask byte
                mask5Stream &= 0xf7;
                memcpy(bigBuf+sizeof(metaData), &mask5Stream, sizeof(unsigned int));
                bFile4Done = true;
                fprintf(stderr,"==file 4 done\r\n");
            }
        }

        if ( !bFile5Done ) {
            //then send the stream heaer of stream 5
            result = realtimeParser5.readData(fd5, &bufLen);
            if ( result ) {
                //then send the stream heaer of stream 5
                unsigned char streamIdSource[] = {0x22, 0x0};//mobile stream
                memcpy(buffer, &streamIdSource, sizeof(streamIdSource));
                memcpy(buffer+sizeof(streamIdSource), &bufLen, sizeof(unsigned int));
                memcpy((char*)buffer+sizeof(streamIdSource)+sizeof(unsigned int), result, bufLen);
                buffer += (sizeof(streamIdSource)+sizeof(unsigned int)+bufLen);
                totalLen += (sizeof(streamIdSource)+sizeof(unsigned int)+bufLen);
            } else {
                //fix the mask byte
                mask5Stream &= 0xef;
                memcpy(bigBuf+sizeof(metaData), &mask5Stream, sizeof(unsigned int));
                bFile5Done = true;
                fprintf(stderr,"==file 5 done\r\n");
            }
        }

        doWrite(1, bigBuf, totalLen);
    }    
    return 1;
}

int main( int argc, char** argv ) {
  if ( argc != 6 ) {
      fprintf(stderr, "usage: %s input_file1 input_file2 input_file3 input_file4 input_file5", argv[0]);
      return -1;
  } 
  //////////////////
  FILE *fp1;

  fp1 = fopen(argv[1], "r");
  if (NULL == fp1) {
    /* Handle Error */
  }

  if (fseek(fp1, FLV_START_POS , SEEK_SET) != 0) {
    /* Handle Error */
  }

  //////////////////
  FILE *fp2;

  fp2 = fopen(argv[2], "r");
  if (NULL == fp2) {
    /* Handle Error */
  }

  if (fseek(fp2, FLV_START_POS , SEEK_SET) != 0) {
    /* Handle Error */
  }
  //////////////////
  FILE *fp3;

  fp3 = fopen(argv[3], "r");
  if (NULL == fp3) {
    /* Handle Error */
  }

  if (fseek(fp3, FLV_START_POS , SEEK_SET) != 0) {
    /* Handle Error */
  }

  //////////////////
  FILE *fp4;

  fp4 = fopen(argv[4], "r");
  if (NULL == fp4) {
    /* Handle Error */
  }

  if (fseek(fp4, FLV_START_POS , SEEK_SET) != 0) {
    /* Handle Error */
  }

  //////////////////
  FILE *fp5;

  fp5 = fopen(argv[5], "r");
  if (NULL == fp5) {
    /* Handle Error */
  }

  if (fseek(fp5, FLV_START_POS , SEEK_SET) != 0) {
    /* Handle Error */
  }

  ///////////////
  runTest( fp1, fp2, fp3, fp4, fp5);
  return 0;
}