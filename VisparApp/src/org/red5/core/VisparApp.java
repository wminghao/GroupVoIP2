package org.red5.core;

import java.util.HashSet;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.scope.IScope;
import org.red5.server.api.Red5;
import org.red5.server.api.service.IPendingServiceCall;
import org.red5.server.api.service.IPendingServiceCallback;
import org.red5.server.api.service.IServiceCapableConnection;
import org.red5.server.api.stream.IBroadcastStream;
import org.red5.server.api.stream.IPlayItem;
import org.red5.server.api.stream.IPlaylistSubscriberStream;
import org.red5.server.api.stream.IStreamAwareScopeHandler;
import org.red5.server.api.stream.ISubscriberStream;
import org.red5.server.net.rtmp.RTMPConnection;

public class VisparApp extends ApplicationAdapter implements
		IPendingServiceCallback, IStreamAwareScopeHandler {

    protected static Logger log = LoggerFactory.getLogger(VisparApp.class);
    
    private Set<String> publisherList = new HashSet<String>();

	/** {@inheritDoc} */
    @Override
	public boolean appStart(IScope scope) {
		// init your handler here
		return true;
	}

	/** {@inheritDoc} */
    @Override
	public boolean appConnect(IConnection conn, Object[] params) {
		IServiceCapableConnection service = (IServiceCapableConnection) conn;
		log.info("Client connected {} conn {}", new Object[]{conn.getClient().getId(), conn});
		service.invoke("setId", new Object[] { conn.getClient().getId() },
						this);
		return true;
	}

	/** {@inheritDoc} */
    @Override
	public boolean appJoin(IClient client, IScope scope) {
		log.info("Client joined app {}", client.getId());
		// If you need the connecion object you can access it via.
		IConnection conn = Red5.getConnectionLocal();
		return true;
	}


	/** {@inheritDoc}
	 * When a room is connected, the first thing we do is tell the client who else is publishing.
	 * So that the client gets the notification.
	 *  */
    @Override
	public boolean roomConnect(IConnection conn, Object[] params) {
		//notify clients of all stream published, in comma deliminated form
		String publisherListNames = "";
		int totalPublishers = publisherList.size();
		int i = 0;
		for (String publisherName : publisherList) {
			publisherListNames += publisherName;
			if( (++i) < totalPublishers) {
				publisherListNames += ",";
			}
		}
        sendToClient(conn, "initStreams", publisherListNames);
    	return true;
	}
    
	/** {@inheritDoc} 
	 * When a stream publishes, we notify all other connections that the person has been added as a publisher.
	 * Should be roomscope instead of Application scope
	 * */
    public void streamPublishStart(IBroadcastStream stream) {
    	// Notify all the clients that the stream had been started
    	if (log.isDebugEnabled()) {
    		log.debug("stream broadcast start: {}", stream.getPublishedName());
    	}
    	IConnection current = Red5.getConnectionLocal();
    	IScope roomScope = current.getScope(); //RoomScope 
        for(Set<IConnection> connections : roomScope.getConnections()) {
            for (IConnection conn: connections) {
                if (conn.equals(current)) {
                    // Don't notify current client
                    continue;
                }

                sendToClient(conn, "addStream", stream.getPublishedName());
            }
        }
        publisherList.add(stream.getPublishedName());
    }

	/** {@inheritDoc} */
    public void streamRecordStart(IBroadcastStream stream) {
	}

	/** {@inheritDoc} 
	 * 
	 * When a stream publish closes, we notify all other connections that the person has been removed as a publisher.
	 * Should be roomscope instead of Application scope
	 * 
	 * */
    public void streamBroadcastClose(IBroadcastStream stream) {
    	//notify the connections that a stream is unpublished
    	IConnection current = Red5.getConnectionLocal();
    	IScope roomScope = current.getScope(); //RoomScope 
        for(Set<IConnection> connections : roomScope.getConnections()) {
            for (IConnection conn: connections) {
                if (conn.equals(current)) {
                    // Don't notify current client
                    continue;
                }
                sendToClient(conn, "removeStream", stream.getPublishedName());
            }
		}

        publisherList.remove(stream.getPublishedName());
    	super.streamBroadcastClose(stream);
	}

	/** {@inheritDoc} */
    public void streamBroadcastStart(IBroadcastStream stream) {
	}

	/** {@inheritDoc} */
    public void streamPlaylistItemPlay(IPlaylistSubscriberStream stream,
			IPlayItem item, boolean isLive) {
	}

	/** {@inheritDoc} */
    public void streamPlaylistItemStop(IPlaylistSubscriberStream stream,
			IPlayItem item) {

	}

	/** {@inheritDoc} */
    public void streamPlaylistVODItemPause(IPlaylistSubscriberStream stream,
			IPlayItem item, int position) {

	}

	/** {@inheritDoc} */
    public void streamPlaylistVODItemResume(IPlaylistSubscriberStream stream,
			IPlayItem item, int position) {

	}

	/** {@inheritDoc} */
    public void streamPlaylistVODItemSeek(IPlaylistSubscriberStream stream,
			IPlayItem item, int position) {

	}

	/** {@inheritDoc} */
    public void streamSubscriberClose(ISubscriberStream stream) {

	}

	/** {@inheritDoc} */
    public void streamSubscriberStart(ISubscriberStream stream) {
	}

	/**
	 * Get streams. called from client
	 * @return iterator of broadcast stream names
	 */
	public Set<String> getStreams() {
		IConnection conn = Red5.getConnectionLocal();
		return (Set<String>) getBroadcastStreamNames(conn.getScope());
	}

	/**
	 * Handle callback from service call. 
	 */
	public void resultReceived(IPendingServiceCall call) {
		log.info("Received result {} for {}", new Object[]{call.getResult(), call.getServiceMethodName()});
	}
	
	/*
	 * Server calling (flash) client events such as: onSongSelected, addStream, removeStream, initStream, etc.
	 */
	private void sendToClient(IConnection conn, String methodName, String param) {
		if (conn instanceof IServiceCapableConnection) {
            ((IServiceCapableConnection) conn).invoke(methodName,
                    new Object[] { param }, this);
            if (log.isDebugEnabled()) {
                log.debug("sending {} notification to {}", methodName, conn);
            }
        }
	}	
	
	private void sendToClient2(IConnection conn, String methodName, Boolean param1) {
		if (conn instanceof IServiceCapableConnection) {
            ((IServiceCapableConnection) conn).invoke(methodName,
                    new Object[] { param1 }, this);
            if (log.isDebugEnabled()) {
                log.debug("sending {} notification to {}", methodName, conn);
            }
        }
	}

	/*
	 * Notification when a video is playing
	 */
    public void onVideoPlaying(String videoName) {
    	super.onVideoPlaying(videoName);
    	IConnection current = Red5.getConnectionLocal();
    	IScope roomScope = current.getScope(); //RoomScope 
        for(Set<IConnection> connections : roomScope.getConnections()) {
            for (IConnection conn: connections) {
                sendToClient(conn, "onVideoSelected", videoName);
            }
        }
    }

    public void onVideoListPopulated(String streamName, String videoListNames) {
    	super.onVideoListPopulated(streamName, videoListNames);
    	IConnection current = Red5.getConnectionLocal();
    	IScope roomScope = current.getScope(); //RoomScope 
        for(Set<IConnection> connections : roomScope.getConnections()) {
            for (IConnection conn: connections) {
            	if( conn instanceof RTMPConnection ) {
            		RTMPConnection rtmpConn = (RTMPConnection) conn;
            		String publisherName = rtmpConn.getPublisherStreamName();
            		if( publisherName!=null && publisherName.equals(streamName) ) {
            			sendToClient(conn, "onVideoListPopulated", videoListNames);
            		}
            	}
            }
        }
    }

    public void onRequest2TalkApproved(Boolean isAllow, String userName) {
    	super.onRequest2TalkApproved(isAllow, userName);
    	IConnection current = Red5.getConnectionLocal();
    	IScope roomScope = current.getScope(); //RoomScope 
        for(Set<IConnection> connections : roomScope.getConnections()) {
            for (IConnection conn: connections) {
                if (conn instanceof RTMPConnection) {
                	if( ((RTMPConnection)conn).getUser() == userName){
                		sendToClient2(conn, "onRequest2TalkApproved", isAllow);
                	}
                }
            }
        }
    }
    
    public void onRequest2TalkNeedsApproval(String user ){
    	super.onRequest2TalkNeedsApproval(user);
    	IConnection current = Red5.getConnectionLocal();
    	IScope roomScope = current.getScope(); //RoomScope 
        for(Set<IConnection> connections : roomScope.getConnections()) {
            for (IConnection conn: connections) {
                if (conn instanceof RTMPConnection) {
                	if( ((RTMPConnection)conn).isModerator()){
                		log.info("Find moderator, send to him {}", ((RTMPConnection)conn).getUser());
                		sendToClient(conn, "onRequest2TalkNeedsApproval", user);
                	}
                }
            }
        }
    }
}