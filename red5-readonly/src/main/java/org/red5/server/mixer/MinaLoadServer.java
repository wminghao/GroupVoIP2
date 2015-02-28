package org.red5.server.mixer;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.charset.Charset;

import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.core.service.IoAcceptor;
import org.apache.mina.filter.codec.ProtocolCodecFilter;
import org.apache.mina.filter.codec.textline.TextLineCodecFactory;
import org.apache.mina.filter.logging.LoggingFilter;
import org.apache.mina.transport.socket.nio.NioSocketAcceptor;
import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;

public class MinaLoadServer {
	public static final int PORT = 1080;
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    private IoAcceptor acceptor = null;
	
    public MinaLoadServer(){
	}
	public void start() {
        try {
    		log.info("MinaLoadServer Transport bind");
        	acceptor = new NioSocketAcceptor();
            //acceptor.getFilterChain().addLast( "logger", new LoggingFilter() );
            acceptor.getFilterChain().addLast( "codec", new ProtocolCodecFilter( new TextLineCodecFactory( Charset.forName( "UTF-8" ))));
            acceptor.setHandler(  new MinaLoadServerHandler() );
            acceptor.getSessionConfig().setReadBufferSize( 2048 );
            acceptor.getSessionConfig().setIdleTime( IdleStatus.BOTH_IDLE, 10 );
			acceptor.bind( new InetSocketAddress(PORT) );
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void stop() {
		log.info("MinaLoadServer Transport unbind");
		if( acceptor != null ) {
            try {
        		acceptor.unbind();
    		} catch (Exception e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
    		acceptor = null;
    	}		
	}
}
