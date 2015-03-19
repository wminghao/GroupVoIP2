package org.red5.server.mixer;

import org.apache.mina.core.service.IoHandler;
import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.core.session.IoSession;
import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;

public class MinaRoomClientSessionHandler implements IoHandler {

	private static Logger log = Red5LoggerFactory.getLogger(Red5.class);

	private Delegate delegate_ = null;
	
    /////////////////////////
    // public functions
    /////////////////////////
    public interface Delegate {
    	public void onSessionClosed(IoSession session);		
    }    
    
	public MinaRoomClientSessionHandler(Delegate dele) {
		delegate_ = dele;
	}
	
	@Override
	public void sessionCreated(IoSession session) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void sessionOpened(IoSession session) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void sessionClosed(IoSession session) throws Exception {
		delegate_.onSessionClosed(session);
	}

	@Override
	public void sessionIdle(IoSession session, IdleStatus status) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public void exceptionCaught(IoSession session, Throwable cause) throws Exception {
		// TODO Auto-generated method stub
	}

	@Override
	public void messageReceived(IoSession session, Object message) throws Exception {
		//log.info("=====MinaClient sent message from the server {}", message.toString());
	}

	@Override
	public void messageSent(IoSession session, Object message) throws Exception {
		//log.info("=====MinaClient received message to the server {}", message.toString());
	}

}
