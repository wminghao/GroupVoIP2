package org.red5.core;

import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.red5.server.api.IConnection;
import org.red5.server.api.Red5;
import org.red5.server.api.scope.IScope;
import org.red5.server.api.service.IServiceCapableConnection;
import org.red5.server.net.rtmp.RTMPConnection;

public class ClientRequestService {
    protected static Logger log = LoggerFactory.getLogger(VisparApp.class);
	public void selectVideo(String videoName) {

		IConnection conn = Red5.getConnectionLocal();

        if (conn instanceof RTMPConnection) {
        	((RTMPConnection) conn).selectVideo(videoName);
        }
	}
	public Boolean isEmptyStream() {
		Boolean isEmpty = true;
		IConnection conn = Red5.getConnectionLocal();

        if (conn instanceof RTMPConnection) {
        	isEmpty = ((RTMPConnection) conn).isEmptyStream();
        }
        return isEmpty;
	}
	//approval process
	public void setAsUser(String user, boolean isModerator) {
		IConnection conn = Red5.getConnectionLocal();
        if (conn instanceof RTMPConnection) {
        	((RTMPConnection)conn).setAsUser(user, isModerator);
        }		
	}
	public void request2Talk(String user) {
		IConnection conn = Red5.getConnectionLocal();
        if (conn instanceof RTMPConnection) {
        	((RTMPConnection)conn).request2Talk(user);
        }
	}
	public void approveRequest2Talk(Boolean isAllow, String user) {
		IConnection conn = Red5.getConnectionLocal();
        if (conn instanceof RTMPConnection) {
        	((RTMPConnection)conn).approveRequest2Talk(isAllow, user);
        }
	}
}
