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

//#define TEST_DUMMY

#ifdef TEST_DUMMY
const char* MIXER_PROCESS_LOCATION = "dummy";//"/usr/bin/dummy";
#else
const char* MIXER_PROCESS_LOCATION = "mix_coder";//"/usr/bin/mix_coder";
#endif

const char* LD_LIBRARY_PATH = "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:.";

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
    {
        std::vector<char *> strings;
        strings.push_back( strdup( MIXER_PROCESS_LOCATION ) );
        //strings.push_back( strdup( more arg ) );
        size_t arrayLen = strings.size() + 1;
        arguments = new char *[ arrayLen ];
        for ( size_t i = 0 ; i < arrayLen - 1 ; ++i ) {
            arguments[i] = strings[i];
        }
        arguments[ arrayLen - 1 ] = NULL;
    }

    char **env;
    {
        std::vector<char *> stringsEnv;
        stringsEnv.push_back( strdup( LD_LIBRARY_PATH ) );
        size_t arrayLenEnv = stringsEnv.size() + 1;
        env = new char *[ arrayLenEnv ];
        for ( size_t i = 0 ; i < arrayLenEnv - 1 ; ++i ) {
            env[i] = stringsEnv[i];
            //OUTPUT("env[%d]=%s", i, env[i]);
        }
        env[ arrayLenEnv - 1 ] = NULL;
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
        
        //Howard, this flag is causing a serious issue with parent thread dies killing child process.
        //  The bug behaves the following way:
        //    1) userA stream joins to start a movieStream, 2) userB stream joins to watch it together. 3) userA exits, 4) mixer crashes. 5) userB stream cannot see the mixed result.
        //  The stackoverflow thread is as follows:
        //    ==>http://stackoverflow.com/questions/26285133/who-sends-a-sigkill-to-my-process-mysteriously-on-ubuntu-server
        //That's not what we want. Instead we want parent process dies killing child process.
        //   Even commenting out the code will let the parent process and child process die at the same time. Maybe it's the default Ubuntu behavior.
        /*
        if( 0 > prctl( PR_SET_PDEATHSIG, SIGKILL ) ) {
            perror( "prctl" );
        }
        */

        //somehow execve does not work, have to change /etc/ld.so.conf.d/
        //if( -1 == execve( MIXER_PROCESS_LOCATION, arguments, env ) ) {
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
    delete [] env;
    
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
