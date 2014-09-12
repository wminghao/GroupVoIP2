#include <string>
#include <sstream>
#include <syslog.h>
#include <iomanip>
#include <fstream>
#include "Logger.h"

void Logger::initLog( const char* syslogName)
{
    openlog( syslogName, LOG_PID, LOG_USER );
}

void Logger::log( const char * fmt, ... )
{
    va_list args;

    /* initialize valist for num number of arguments */
    va_start(args, fmt);
    vsyslog( LOG_DEBUG, fmt, args );
    va_end(args);
}
