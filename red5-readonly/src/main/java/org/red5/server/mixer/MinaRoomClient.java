package org.red5.server.mixer;

import java.net.InetSocketAddress;
import java.nio.charset.Charset;

import org.apache.mina.core.RuntimeIoException;
import org.apache.mina.core.future.ConnectFuture;
import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.codec.ProtocolCodecFilter;
/*
import org.apache.mina.core.buffer.IoBuffer;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CharsetEncoder;
import org.apache.mina.filter.codec.ProtocolDecoder;
import org.apache.mina.filter.codec.ProtocolDecoderOutput;
import org.apache.mina.filter.codec.ProtocolEncoder;
import org.apache.mina.filter.codec.ProtocolEncoderOutput;
import org.apache.mina.filter.codec.ProtocolCodecFactory;
import org.apache.mina.filter.codec.serialization.ObjectSerializationCodecFactory;
import org.apache.mina.filter.logging.LoggingFilter;
*/
import org.apache.mina.filter.codec.textline.TextLineCodecFactory;
import org.apache.mina.transport.socket.nio.NioSocketConnector;
import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;

public class MinaRoomClient implements MinaRoomClientSessionHandler.Delegate{
	private static final long CONNECT_TIMEOUT = 30;
	private static final int PORT = 8001;
	private static final String HOSTNAME = "localhost";
    private IoSession session_ = null;
	private NioSocketConnector connector_ = null;
	private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    
	//TODO persistent connection
	
    public MinaRoomClient() {
    	connect();
    }
    private void connect() {
    	connector_ = new NioSocketConnector();
    	connector_.setConnectTimeoutMillis(CONNECT_TIMEOUT);

    	connector_.getFilterChain().addLast("codec", new ProtocolCodecFilter(new TextLineCodecFactory( Charset.forName( "UTF-8" ))));
    	//connector_.getFilterChain().addLast("logger", new LoggingFilter());
    	connector_.setHandler(new MinaRoomClientSessionHandler(this));
        try {
            ConnectFuture future = connector_.connect(new InetSocketAddress(HOSTNAME, PORT));
            future.awaitUninterruptibly();
            session_ = future.getSession();
            log.info("====Mina CLient connection established!");
        } catch (RuntimeIoException e) {
        	e.printStackTrace();
            log.info("====Mina CLient connection failed!");
        }
    }
    
	public void onRoomCreated(String roomName) {
		String createMessage = "GET /createroom/"+roomName+" HTTP/1.0\r\n\r\n";
		sendToLoadBalancer(createMessage);
	}

	public void onRoomClosed(String roomName) {
		String deleteMessage = "GET /deleteroom/"+roomName+" HTTP/1.0\r\n\r\n";
		sendToLoadBalancer(deleteMessage);
	}
	
	private void sendToLoadBalancer(Object message) {
		if( session_ == null ) {
			connect(); //try to reconnect
		}
		if ( session_ != null ) {
			session_.write(message);
		}
	}
	@Override
	public void onSessionClosed() {
		// wait until the message is sent
		if ( session_ != null ) {
			session_.getCloseFuture().awaitUninterruptibly();
			session_ = null;
		}
        connector_.dispose();
        log.info("====Mina CLient connection closed!");
	}
	/*
	public class ClientHttpRequestEncoder implements ProtocolEncoder {

	    public void encode(IoSession session, Object message, ProtocolEncoderOutput out) throws Exception {
	        String request = (String) message;
	        IoBuffer buffer = IoBuffer.allocate(request.length(), false);
	        Charset charset=Charset.forName("UTF-8");
	        CharsetEncoder utf8encoder=charset.newEncoder();
	        buffer.putString(request, utf8encoder);
	        buffer.flip();
	        out.write(buffer);
	    }

	    public void dispose(IoSession session) throws Exception {
	        // nothing to dispose
	    }
	}

	public class ClientHttpResponseDecoder implements ProtocolDecoder {
		@Override
		public void decode(IoSession session, IoBuffer in, ProtocolDecoderOutput out) throws Exception {
	        Charset charset=Charset.forName("UTF-8");
	        CharsetDecoder utf8decoder=charset.newDecoder();
			out.write(in.getString(utf8decoder));
			in.flip();
		}

		@Override
		public void finishDecode(IoSession session, ProtocolDecoderOutput out) throws Exception {
			//nothing
		}

		@Override
		public void dispose(IoSession session) throws Exception {
	        // nothing to dispose			
		}
	}
	public class HttpRequestCodecFactory implements ProtocolCodecFactory {
	    private ProtocolEncoder encoder;
	    private ProtocolDecoder decoder;

	    public HttpRequestCodecFactory() {
            encoder = new ClientHttpRequestEncoder();
            decoder = new ClientHttpResponseDecoder();
	    }

	    public ProtocolEncoder getEncoder(IoSession ioSession) throws Exception {
	        return encoder;
	    }

	    public ProtocolDecoder getDecoder(IoSession ioSession) throws Exception {
	        return decoder;
	    }
	}
	*/
}
