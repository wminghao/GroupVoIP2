#include "ProcessPipe.h"
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

#define MIXER_PROCESS_LOCATION "/usr/bin/mix_coder"

ProcessPipe::ProcessPipe()
{    
}
ProcessPipe::~ProcessPipe()
{
}
int ProcessPipe::getInFd() 
{
    return 0;
}

int ProcessPipe::getOutFd()
{
    return 0;
}

void ProcessPipe::close()
{
    return;
}
