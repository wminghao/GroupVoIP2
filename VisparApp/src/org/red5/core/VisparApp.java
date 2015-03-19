package org.red5.core;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
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
    private Map<IScope, Set<String>> publisherListMap = new HashMap<IScope, Set<String>>();

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
		boolean bIsAllInOneConn = false;
		if(conn instanceof RTMPConnection) {
			bIsAllInOneConn = ((RTMPConnection)conn).isAllInOneConn();
		}
		if( !bIsAllInOneConn ) {
			service.invoke("setId", new Object[] { conn.getClient().getId() },
							this);
		}
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
    	IScope roomScope = conn.getScope(); //RoomScope 
    	Set<String> publisherList = publisherListMap.get(roomScope);
    	if( publisherList != null ) {
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
			boolean bIsAllInOneConn = false;
			if(conn instanceof RTMPConnection) {
				bIsAllInOneConn = ((RTMPConnection)conn).isAllInOneConn();
			}
			if( !bIsAllInOneConn ) {
				sendToClient(conn, "initStreams", new Object[] {publisherListNames});
			}
        
	        //send the list of talker only mode to the client as well
	    	String audioOnlyListNames = "";
	        for(Set<IConnection> connections : roomScope.getConnections()) {
	            for (IConnection iConnection: connections) {
	                if (iConnection instanceof RTMPConnection) {
	                	if( iConnection != null && 
	                		((RTMPConnection)iConnection).getUser() != null && 
	                		((RTMPConnection)iConnection).isAudioOnly() ){
	                		audioOnlyListNames+= ((RTMPConnection)iConnection).getUser();
	                		audioOnlyListNames+=",";
	                	}
	                }
	            }
	        }
			if( !bIsAllInOneConn ) {
				sendToClient(conn, "initAudioOnlyStreams", new Object[] {audioOnlyListNames});
			}
    	}
        
        if (conn instanceof RTMPConnection) {
        	if( ((RTMPConnection)conn).isExternalVideoGenerated() ) {
        		log.info("Send onExternalVideoStarted {}", ((RTMPConnection)conn).getUser());
        		sendToClient(conn, "onExternalVideoStarted", null);        		
        	}
        }
        
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
                boolean bIsAllInOneConn = false;
        		if(conn instanceof RTMPConnection) {
        			bIsAllInOneConn = ((RTMPConnection)conn).isAllInOneConn();
        		}
        		if( !bIsAllInOneConn ) {
        			sendToClient(conn, "addStream", new Object[] {stream.getPublishedName()});
        		}
            }
        }
    	Set<String> publisherList = publisherListMap.get(roomScope);
        if( publisherList == null) {
        	publisherList = new HashSet<String>();
        	publisherListMap.put(roomScope, publisherList);
        }
        if( publisherList != null) {
        	publisherList.add(stream.getPublishedName());
        }
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
                boolean bIsAllInOneConn = false;
        		if(conn instanceof RTMPConnection) {
        			bIsAllInOneConn = ((RTMPConnection)conn).isAllInOneConn();
        		}
        		if( !bIsAllInOneConn ) {
        			sendToClient(conn, "removeStream", new Object[] {stream.getPublishedName()});
        		}
            }
		}

    	Set<String> publisherList = publisherListMap.get(roomScope);
        if( publisherList != null) {
        	publisherList.remove(stream.getPublishedName());
        	if( publisherList.isEmpty() ) {
        		publisherListMap.remove(roomScope);
        	}
        }
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
	private void sendToClient(IConnection conn, String methodName, Object[] obj) {
		if (conn instanceof IServiceCapableConnection) {
            ((IServiceCapableConnection) conn).invoke(methodName,
                    obj, this);
            if (log.isDebugEnabled()) {
                log.debug("sending {} notification to {}", methodName, conn);
            }
        }
	}

	/*
	 * Notification when a video is playing
	 */
    public void onExternalVideoPlaying(String videoName) {
    	super.onExternalVideoPlaying(videoName);
    	IConnection current = Red5.getConnectionLocal();
    	IScope roomScope = current.getScope(); //RoomScope 
        for(Set<IConnection> connections : roomScope.getConnections()) {
            for (IConnection conn: connections) {
            	if( conn!=null && conn instanceof RTMPConnection && ((RTMPConnection)conn).getUser() != null ) {
            		log.info("Send onExternalVideoPlaying {} about videoName {}", ((RTMPConnection)conn).getUser(), videoName);
            		sendToClient(conn, "onExternalVideoPlaying",  new Object[] { videoName });
            	}
            }
        }
    }
    public void onExternalVideoStarted() {
    	super.onExternalVideoStarted();
    	IConnection current = Red5.getConnectionLocal();
    	IScope roomScope = current.getScope(); //RoomScope 
        for(Set<IConnection> connections : roomScope.getConnections()) {
            for (IConnection conn: connections) {
            	if( conn!=null && conn instanceof RTMPConnection && ((RTMPConnection)conn).getUser() != null ) {
            		log.info("Send onExternalVideoStarted {}", ((RTMPConnection)conn).getUser());
            		sendToClient(conn, "onExternalVideoStarted", null);
            	}
            }
        }
    }
    public void onExternalVideoStopped() {
    	super.onExternalVideoStopped();
    	IConnection current = Red5.getConnectionLocal();
    	IScope roomScope = current.getScope(); //RoomScope 
        for(Set<IConnection> connections : roomScope.getConnections()) {
            for (IConnection conn: connections) {
            	if( conn!=null && conn instanceof RTMPConnection && ((RTMPConnection)conn).getUser() != null ) {
            		log.info("Send onExternalVideoStopped {}", ((RTMPConnection)conn).getUser());
            		sendToClient(conn, "onExternalVideoStopped", null);
            	}
            }
        }
    }

    public void onExternalVideoListPopulated(String streamName, String videoListNames) {
    	super.onExternalVideoListPopulated(streamName, videoListNames);
    	IConnection current = Red5.getConnectionLocal();
    	IScope roomScope = current.getScope(); //RoomScope 
        for(Set<IConnection> connections : roomScope.getConnections()) {
            for (IConnection conn: connections) {
            	if( conn instanceof RTMPConnection ) {
            		RTMPConnection rtmpConn = (RTMPConnection) conn;
            		String publisherName = rtmpConn.getPublisherStreamName();
            		if( publisherName!=null && publisherName.equals(streamName) ) {
                    	if( conn!=null && conn instanceof RTMPConnection && ((RTMPConnection)conn).getUser() != null ) {
                    		sendToClient(conn, "onExternalVideoListPopulated", new Object[] { videoListNames});
                    	}
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
                if (conn!=null && conn instanceof RTMPConnection) {
                	String currentUser = ((RTMPConnection)conn).getUser();
                	if( currentUser!=null && currentUser.equalsIgnoreCase(userName) ){
                		log.info("onRequest2TalkApproved userName {} isAllow {}", userName, isAllow);
                		sendToClient(conn, "onRequest2TalkApproved", new Object[] {isAllow});
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
                	if( conn!=null && ((RTMPConnection)conn).isModerator()){
                		log.info("Find moderator, send to {} to approve {}", ((RTMPConnection)conn).getUser(), user);
                		sendToClient(conn, "onRequest2TalkNeedsApproval", new Object[] {user});
                	}
                }
            }
        }
    }
    
    public void onUserJoinedTalk(String user, int avFlag) {
    	super.onRequest2TalkNeedsApproval(user);
    	IConnection current = Red5.getConnectionLocal();
    	IScope roomScope = current.getScope(); //RoomScope 
        for(Set<IConnection> connections : roomScope.getConnections()) {
            for (IConnection conn: connections) {
                if (conn instanceof RTMPConnection) {
                	if( conn != null && ((RTMPConnection)conn).getUser() != null ){
                		log.info("onUserJoinedTalk, send to {} that {} is in {} avflag", ((RTMPConnection)conn).getUser(), user, avFlag);
                		sendToClient(conn, "onUserJoinedTalk", new Object[] {user, avFlag});
                	}
                }
            }
        }
    }
}