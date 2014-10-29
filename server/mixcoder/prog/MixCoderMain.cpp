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
#include <sys/resource.h>
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

void fnExit (void)
{
    LOG("----MixCoder Exited!");
}

/*
 * Signal handler for kill signal
 */
void sigkill_sigaction(int signal __attribute__ ((unused)), siginfo_t *si, void *arg __attribute__ ((unused)))
{
    LOG("Caught sigkill at address %p, sent by pid: %d\n", si->si_addr, si->si_pid);
}

//big enough buffer
const int MAX_BUF_SIZE = 512;//4096;

int main( int argc, char** argv ) {
    atexit(fnExit);
    signal( SIGPIPE, SIG_IGN );
    signal( SIGHUP, SIG_IGN ); //ignore hangup
    signal( SIGSEGV, handlesig );
    signal( SIGFPE, handlesig );
    signal( SIGBUS, handlesig );
    signal( SIGSYS, handlesig );
    signal( SIGTERM, handlesig );
    signal( SIGQUIT, handlesig );
    signal( SIGINT, handlesig );
    signal( SIGILL, handlesig );    
    signal( SIGABRT, handlesig );
    signal( SIGALRM, handlesig );
    signal( SIGXCPU, handlesig ); //CPU limit
    // SIGKILL command cannot be caught

    Logger::initLog("MixCoder", kSyslog);

    struct sigaction sa;

    /* Set up to catch sigkill */
    //Can NEVER catch sigkill
    /*memset(&sa, 0, sizeof(sa));
    sigemptyset(&sa.sa_mask);
    sa.sa_sigaction = sigkill_sigaction;
    //sa.sa_flags   = SA_SIGKILL;
    int res = sigaction(SIGKILL, &sa, NULL);
    LOG("------ret=%d", res);
    */

    //write to /tmp directory
    const char *directory = "/tmp";
    int ret = chdir (directory);
    rlimit core_limit = { RLIM_INFINITY, RLIM_INFINITY };
    if( setrlimit( RLIMIT_CORE, &core_limit ) == 0 ) {
        //LOG("---Core dump enabled.");
    }
    struct rlimit limit;
    if (getrlimit(RLIMIT_CORE, &limit) != 0) {
        LOG("getrlimit() failed\n");
    }
    //LOG("---rlmit, core dump limit cur=%d, limit max=%d", limit.rlim_cur, limit.rlim_max);

    rlimit core_limit2 = { 65535, 65535 };
    if( setrlimit( RLIMIT_NOFILE, &core_limit2 ) == 0 ) {
        //LOG("---file handler enabled.");
    }
    struct rlimit limit2;
    if (getrlimit(RLIMIT_NOFILE, &limit2) != 0) {
        LOG("getrlimit() failed\n");
    }
    //LOG("---rlmit, open file limit cur=%d, limit max=%d", limit2.rlim_cur, limit2.rlim_max);
    
    VideoCodecId codecOutputId = kAVCVideoPacket; //kH263VideoPacket;//kAVCVideoPacket;//kVP6VideoPacket;//

    int videoBitrate = 100; //increase from 40 to 100, with base tier 100kbps
    if( codecOutputId != kVP8VideoPacket ) {
        videoBitrate = 300; //300kbps
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
