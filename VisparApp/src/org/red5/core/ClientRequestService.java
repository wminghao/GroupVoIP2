package org.red5.core;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.red5.server.api.IConnection;
import org.red5.server.api.Red5;
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
}
