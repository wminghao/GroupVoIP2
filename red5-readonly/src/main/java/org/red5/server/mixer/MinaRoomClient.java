package org.red5.server.mixer;

import java.net.InetSocketAddress;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

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
import org.red5.server.api.scope.IScope;
import org.slf4j.Logger;

public class MinaRoomClient implements MinaRoomClientSessionHandler.Delegate{
	private static final long CONNECT_TIMEOUT = 30;

	private String roomLookupServerIp;
	private String roomLookupServerPathPrefix;
	private int roomLookupServerPort;
	private static Logger log = Red5LoggerFactory.getLogger(Red5.class);

	//map to different connections, accessed from different threads
	private Map<IoSession,NioSocketConnector> connPool_ = new HashMap<IoSession, NioSocketConnector>();
	private Object syncObj = new Object();
	
	//TODO persistent connection	
    public MinaRoomClient() {
    }
    
    public void setServerInfo(String roomLookupServerIp, String pathPrefix, int roomLookupServerPort) {
    	this.roomLookupServerIp = roomLookupServerIp;
    	this.roomLookupServerPathPrefix = pathPrefix;
    	this.roomLookupServerPort = roomLookupServerPort;    
		log.info("MinaRoomClient connect to ip:{} port: {}", roomLookupServerIp, roomLookupServerPort);
    }
    
    private IoSession connect() {
    	IoSession session = null;
    	NioSocketConnector connector = new NioSocketConnector();
    	connector.setConnectTimeoutMillis(CONNECT_TIMEOUT);

    	connector.getFilterChain().addLast("codec", new ProtocolCodecFilter(new TextLineCodecFactory( Charset.forName( "UTF-8" ))));
    	//connector_.getFilterChain().addLast("logger", new LoggingFilter());
    	connector.setHandler(new MinaRoomClientSessionHandler(this));
        try {
            ConnectFuture future = connector.connect(new InetSocketAddress(roomLookupServerIp, roomLookupServerPort));
            future.awaitUninterruptibly();
            session = future.getSession();
            synchronized (syncObj) {
            	connPool_.put(session, connector);
            }
            log.info("====Mina CLient connection established!");
        } catch (RuntimeIoException e) {
        	e.printStackTrace();
            log.info("====Mina CLient connection failed!");
        }
        return session;
    }
    
	public void onRoomCreated(String roomName) {
		//POST
		String createMessage = "GET "+this.roomLookupServerPathPrefix+"createroom/"+roomName+" HTTP/1.0\r\n\r\n";
		sendToLoadBalancer(createMessage);
	}

	public void onRoomClosed(String roomName) {
		//DELETE
		String deleteMessage = "GET "+this.roomLookupServerPathPrefix+"deleteroom/"+roomName+" HTTP/1.0\r\n\r\n";
		sendToLoadBalancer(deleteMessage);
	}
	
	private void sendToLoadBalancer(Object message) {
    	IoSession session = connect(); //try to reconnect
		if ( session != null ) {
			session.write(message);
		}
	}
	@Override
	public void onSessionClosed(IoSession session) {
		// wait until the message is sent
		if ( session != null ) {
			NioSocketConnector connector = null;
            synchronized (syncObj) {
    			if( connPool_.containsKey(session)) {
    				connector = connPool_.get(session);
    				connPool_.remove(session);
    			}
            }
            session.getCloseFuture().awaitUninterruptibly();
            if( connector != null ) {
            	connector.dispose();
    			log.info("====Mina CLient connection closed!");
            }
		}
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
