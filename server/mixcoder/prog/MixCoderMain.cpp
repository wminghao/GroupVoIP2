#include "MixCoder.h"
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/param.h>
#include <sys/fcntl.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/signal.h>
#include <execinfo.h>
#include <sys/types.h>
#include "fwk/log.h"
#include "CodecInfo.h"

void handlesig( int signum )
{    
    LOG( "Exiting on signal: %d", signum  );
    LOG( "GroupVoip just crashed, see stack dump below." );
    LOG( "---------------------------------------------");
    void *array[10];
    size_t bt_size;

    // get void*'s for all entries on the stack
    bt_size = backtrace(array, 10);

    // print out all the frames to stderr
    char **bt_syms = backtrace_symbols(array, bt_size);
    for (size_t i = 1; i < bt_size; i++) {
        //size_t len = strlen(bt_syms[i]);
        LOG("%s", bt_syms[i]);
    }
    free( bt_syms );
    LOG( "---------------------------------------------");

    exit( 0 );
}

//big enough buffer
const int MAX_BUF_SIZE = 512;//4096;

int main( int argc, char** argv ) {

    signal( SIGPIPE, SIG_IGN );
    signal( SIGSEGV, handlesig );
    signal( SIGFPE, handlesig );
    signal( SIGBUS, handlesig );
    signal( SIGSYS, handlesig );
    
    Logger::initLog("MixCoder", kSyslog);
    
    VideoCodecId codecOutputId = kAVCVideoPacket; //kH263VideoPacket;//kAVCVideoPacket;//kVP6VideoPacket;//

    int videoBitrate = 100; //increase from 40 to 100, with base tier 100kbps
    if( codecOutputId != kVP8VideoPacket ) {
        videoBitrate = 200; //200kbps
    }
    int videoWidth = 640;
    int videoHeight = 480;

    int audioBitrate = 64; //64kbps
    int audioFrequency = 16000;
    
    MixCoder* mixCoder = new MixCoder(codecOutputId, videoBitrate, videoWidth, videoHeight, audioBitrate, audioFrequency);

    u8 data[MAX_BUF_SIZE];
    SmartPtr<SmartBuffer> output;
    int totalBytesRead = 0;

    //debug code
    int totalOutput = 0;
    while ( (totalBytesRead = read( 0, data, MAX_BUF_SIZE)) > 0 ) {
        SmartPtr<SmartBuffer> input = new SmartBuffer( totalBytesRead, data );
        if( !mixCoder->newInput( input ) ) {
            LOG("input error");
            return -1;
        }
        while( output = mixCoder->getOutput() ) {
            totalOutput+=output->dataLength();
            //LOG("------totalOutput=%d\n", totalOutput);
            write( 1, output->data(), output->dataLength() );
            fflush(stdout);
        } 
    }
    LOG("------final totalOutput=%d\n", totalOutput);
    //flush the remaining
    mixCoder->flush();
    while( output = mixCoder->getOutput() ) {
        write( 1, output->data(), output->dataLength() );
    }

    delete mixCoder;
    return 1;
}
