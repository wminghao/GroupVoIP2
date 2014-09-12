#include "ProcessPipe.h"
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <sys/fcntl.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <sys/signal.h>
#include <sys/types.h>
#include <assert.h>
#include <vector>
#include "Output.h"

#define TEST_DUMMY

#ifdef TEST_DUMMY
const char* MIXER_PROCESS_LOCATION = "dummy";//"/usr/bin/dummy";
#else
const char* MIXER_PROCESS_LOCATION = "mix_coder";//"/usr/bin/mix_coder";
#endif

void killChild() {
    OUTPUT( "MixCoderBridge exiting." );
    //kill(childPid_, SIGKILL);
    //wait(0);
}

ProcessPipe::ProcessPipe()
{    
    atexit(killChild);    
    childPid_ = open();
}
ProcessPipe::~ProcessPipe()
{
    close();
}
int ProcessPipe::getInFd() 
{
    return p_[1];
}

int ProcessPipe::getOutFd()
{
    return q_[0];
}

pid_t ProcessPipe::open()
{
    if ( 0 > pipe( p_ ) || 0 > pipe( q_ ) ) {
        OUTPUT("!!!Failed to create process pipe = %s p_[1]=%d q_[0]=%d" , MIXER_PROCESS_LOCATION, p_[1], q_[0]);        
        perror( "pipe" );
        return -1;
    }
    char **arguments;
    std::vector<char *> strings;
    strings.push_back( strdup( MIXER_PROCESS_LOCATION ) );
    //strings.push_back( strdup( more arg ) );
    size_t arrayLen = strings.size() + 1;
    arguments = new char *[ arrayLen ];
    for ( size_t i = 0 ; i < arrayLen - 1 ; ++i ) {
        arguments[i] = strings[i];
    }
    arguments[ arrayLen - 1 ] = NULL;
    
    pid_t rval = fork();
    
    if( 0 == rval ) {
        //child process
        ::close(p_[1]);
        ::close(q_[0]);
        
        if( 0 > dup2( p_[0], 0 ) ) {
            perror( "dup2 in child p_[0]" );
        }
        
        if( 0 > dup2( q_[1], 1 ) ) {
            perror( "dup2 in child q_[1]" );
        }
        
        if( 0 > prctl( PR_SET_PDEATHSIG, SIGKILL ) ) {
            perror( "prctl" );
        }

        OUTPUT("----Launching child process!\n");
        if( -1 == execvp( MIXER_PROCESS_LOCATION, arguments ) ) {
            assert(0);
            OUTPUT("Fatal error: EXECLP FAILED, error=%d?!\n", errno);
        }

        exit(-1);
    } else {
        //parent process
        ::close(p_[0]);
        ::close(q_[1]);
        OUTPUT("----Launching process=%s, pid=%d", MIXER_PROCESS_LOCATION, rval);
    }    
    delete [] arguments;
    
    return rval;
}

void ProcessPipe::close()
{
    OUTPUT("----Closing process=%s, pid=%d", MIXER_PROCESS_LOCATION, childPid_);
    if ( childPid_ ) {
        ::kill( childPid_, SIGKILL );
        int status;
        while ( waitpid( -1, &status, WNOHANG ) > 0 ) {}
        childPid_ = 0;
    }
    return;
}
