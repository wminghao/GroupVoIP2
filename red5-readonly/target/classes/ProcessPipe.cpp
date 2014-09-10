#include "ProcessPipe.h"
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/fcntl.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <sys/signal.h>
#include <sys/types.h>
#include <vector>
#include "Output.h"

const char* MIXER_PROCESS_LOCATION = "/usr/bin/mix_coder";

void killChild() {
    OUTPUT( "exiting." );
    //kill(childPid_, SIGKILL);
    //wait(0);
}

ProcessPipe::ProcessPipe()
{    
    atexit(killChild);    
    open();
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

void ProcessPipe::open()
{
    if ( 0 > pipe( p_ ) || 0 > pipe( q_ ) ) {
        OUTPUT("!!!Failed to create process pipe = %s p_[1]=%d q_[0]=%d" , MIXER_PROCESS_LOCATION, p_[1], q_[0]);        
        perror( "pipe" );
        return;
    }

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
        
        if( arguments_ ) {
            delete [] arguments_;
        }        

        std::vector<char *> strings;
        strings.push_back( strdup( MIXER_PROCESS_LOCATION ) );
        //strings.push_back( strdup( more arg ) );
        size_t arrayLen = strings.size() + 1;
        arguments_ = new char *[ arrayLen ];
        for ( size_t i = 0 ; i < arrayLen - 1 ; ++i ) {
            arguments_[i] = strings[i];
        }
        arguments_[ arrayLen - 1 ] = NULL;
        
        execv( MIXER_PROCESS_LOCATION, arguments_ );

        OUTPUT("Fatal error: EXECLP FAILED?!\n");

        exit(-1);
    } else {
        //parent process
        ::close(p_[0]);
        ::close(q_[1]);
    }    
}

void ProcessPipe::close()
{
    if( arguments_ ) {
        delete [] arguments_;
    }        
    if ( childPid_ ) {
        ::kill( childPid_, SIGKILL );
        int status;
        while ( waitpid( -1, &status, WNOHANG ) > 0 ) {}
        childPid_ = 0;
    }
    return;
}
