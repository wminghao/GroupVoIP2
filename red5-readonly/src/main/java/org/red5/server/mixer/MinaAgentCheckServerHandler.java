package org.red5.server.mixer;

import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IoSession;
import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.lang.Process;
import java.lang.Runtime;

//caution, must install mpstat -P ALL on all servers
public class MinaAgentCheckServerHandler extends IoHandlerAdapter {
	
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    
    private MinaAgentServerStatus status_;
    
    public MinaAgentCheckServerHandler(MinaAgentServerStatus status) {
    	this.status_ = status;
    }
    
    @Override
    public void exceptionCaught( IoSession session, Throwable cause ) throws Exception
    {
        cause.printStackTrace();
    }
    
    //HAProxy asks it to send results immediately after connection open.
    public void sessionOpened(IoSession session) throws Exception {
    	int cpuUsageAvg = (((int)(MinaAgentServerStatus.cpuUsage() * 100.00)) / MinaAgentServerStatus.noOfCores());
    	int percentageIdle = cpuUsageAvg>100?0:(100-cpuUsageAvg);
    	String ret = String.valueOf(percentageIdle)+"%,"+status_.getStatus()+"\n";	
    	log.info("======load balancer query, ret={}", ret);
    	session.write( ret );
        session.close();
    }
}
