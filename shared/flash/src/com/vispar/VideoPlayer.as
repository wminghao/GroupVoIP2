package com.vispar
{
	public class VideoPlayer extends VideoContainer 
	{
		import flash.display.Sprite;
		import flash.events.*;
		import flash.media.*;
		import flash.net.*;
		import flash.system.*;
		import flash.utils.*;
		
		//netstream and netconnection
		private var streamView:NetStream = null; //must declare outside
		private var videoOthers:Video = null;
		//netconnection
		private var netConn:NetConnection = null;	
		
		//detect connection timeout
		private var connTimeoutTimer:Timer = null;
		private var reconnTimer:Timer = null;		
		
		public function VideoPlayer(container:Sprite, delegate:VideoContainerDelegate, room:String, user:String, mode:String, forceAudioOnly:Boolean)
		{
			super(container, delegate, room, user, mode, forceAudioOnly);
		}
		
		override public function connectServer():void {
			if( netConn == null) {
				logDebug(" null!");				
			}			
			var videoPath:String = "rtmp://"+serverIp+"/vod/";
			// setup connection code
			netConn = new NetConnection();
			netConn.connect(videoPath);
			netConn.addEventListener(NetStatusEvent.NET_STATUS, onConnectionNetStatus);
			netConn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			netConn.client = this;
			
			logDebug("=>connect 2 server!");
			connTimeoutTimer = new Timer(4000, 1);
			connTimeoutTimer.addEventListener(TimerEvent.TIMER, onReconnectTimer);
			connTimeoutTimer.start();
		}
		
		override public function disconnectServer():void {
			if( reconnTimer ) {
				reconnTimer.stop();
			}
			if( connTimeoutTimer ) {
				connTimeoutTimer.stop();
			}
			if( videoOthers ) {
				videoOthers.attachNetStream(null);
				videoOthers.clear();
				container_.removeChild(videoOthers);
				videoOthers = null;
			}
			if( streamView ) {
				streamView.dispose();
				streamView.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				streamView.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
				streamView.close();
				streamView = null;
			}
			if( netConn ) {
				netConn.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);			
				netConn.removeEventListener(NetStatusEvent.NET_STATUS, onConnectionNetStatus);
				netConn.close();
				netConn = null;
			}
			logDebug("=>disconnect from server!");
		}
		
		private function onConnectionNetStatus(event:NetStatusEvent) : void {
			if( connTimeoutTimer ) {
				connTimeoutTimer.stop(); //cancel the timeout timer
			}
			if( reconnTimer ) {
				reconnTimer.stop();
			}
			// did we successfully connect
			if(event.info.code == "NetConnection.Connect.Success") {
				logDebug("NetConnection.Connect.Success!");
				openViewStream();
			} else if(event.info.code == "NetConnection.Connect.Failed" ||
				event.info.code == "NetConnection.Connect.IdleTimeout" ||
				event.info.code == "NetConnection.Connect.Closed"){
				logDebug("Connection code:"+event.info.code+", try reconnecting");
				
				reconnTimer = new Timer(3000, 1);
				reconnTimer.addEventListener(TimerEvent.TIMER, onReconnectTimer);
				reconnTimer.start();	
			} else if(event.info.code == "NetConnection.Connect.Rejected" ||
				event.info.code == "NetConnection.Connect.AppShutdown") {
				logDebug("Connection code:"+event.info.code+". Fatal error");
				disconnectServer();
			} else {
				logDebug("Connection code:"+event.info.code+". Ignore event");
			}
		}
		//TODO try 3 times and fail with an error
		private function onReconnectTimer(e:TimerEvent):void
		{
			logDebug("=>onReconnectTimer reconnecting server.");
			disconnectServer();
			connectServer();
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			logDebug("securityErrorHandler: " + event);
		}
		
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			// ignore AsyncErrorEvent events.
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetStream.Play.StreamNotFound":
					logDebug("Unable to locate video");
					break;
				case "NetStream.Play.Start":
				case "NetStream.Play.Reset":
				case "NetStream.Play.PublishNotify":
				case "NetStream.Play.UnpublishNotify":
				case "NetStream.Video.DimensionChange":
				case "NetStream.Publish.Start":
				case "NetStream.Unpublish.Success":
					break;
				default:
					logDebug("New event: " + event.info.code);
					//Alert.show("Unknown event: " + event.info.code, "Information");
					break;
			}
		}
		
		private function openViewStream():void {
			streamView = new NetStream(netConn);
			
			streamView.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			streamView.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);

			streamView.bufferTime = 1; //1 seconds buffer
			//causes android to fail for unknown reason, anyway, this flag is not helping too much.
			//streamView.useJitterBuffer = true; //audio is mp3, so set buffer to be 0 
			streamView.play("archive_"+room);//"vispar_videos/archive");
			
			videoOthers = new Video();
			videoOthers.attachNetStream(streamView);
			container_.addChild(videoOthers);
			//video.opaqueBackground = 0x000000;
			videoOthers.width = (delegate_.getScreenWidth() - 2*delegate_.getScreenX());
			videoOthers.height = (delegate_.getScreenHeight() - 2*delegate_.getScreenY());
			videoOthers.x = delegate_.getScreenX();
			videoOthers.y = delegate_.getScreenY();
			videoOthers.visible = true;
		}
	}
}