package com.vispar
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;
	
	public class VideoConf extends VideoContainer
	{
		private var streamPub:NetStream = null; //must declare outside, otherwise, gc will recycle it.
		private var streamView:NetStream = null; //must declare outside
		
		private var netConn:NetConnection = null;	
		private var mic:Microphone = null;
		private var camera:Camera = null;
		
		private var mixedStreamPrefix:String = "__mixed__";
		private var appName:String = "VisparApp";
		private var defaultVideo:String = "Default"; //default means video stopped
		private var allinone:String = "allinone";
		
		private var publishDest:String = null;
		private var publishedStreamArray:Vector.<String> = new Vector.<String>();
		
		private var videoSelf:Video = null;
		private var videoOthers:Video = null;
		
		private var isViewOnly_:Boolean = false;
		private var isAudioOnly_:Boolean = false;
		
		//TODO, change it to something else
		private var dataSet:Array = ["testliveA","testliveB","testliveC","testliveD"];
		
		//detect connection timeout
		private var connTimeoutTimer:Timer = null;
		private var reconnTimer:Timer = null; 
		
		public function VideoConf(container:Sprite, delegate:VideoContainerDelegate, room:String)
		{ 
			super(container, delegate, room);
		}
		
		override public function connectServer():void {
			if( netConn == null) {
				//logDebug(" null!");				
			}			
			var videoPath:String = "rtmp://"+serverIp+"/"+appName+"/"+room;
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
			closeViewStream();
			closePublishStream();
			
			if( netConn ) {
				netConn.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);			
				netConn.removeEventListener(NetStatusEvent.NET_STATUS, onConnectionNetStatus);
				netConn.close();
				netConn = null;
			}
			logDebug("=>disconnect from server!");
			
			publishedStreamArray = new Vector.<String>();
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
				delayedFunctionCall(1000, function(e:Event):void {publishNow();});
				logDebug("NetConnection.Connect.Success!");
			} else if(event.info.code == "NetConnection.Connect.Failed" ||
					  event.info.code == "NetConnection.Connect.IdleTimeout" ||
					  event.info.code == "NetConnection.Connect.Closed"){
				logDebug("Connection code:"+event.info.code+", try reconnecting");
				disconnectServer(); //disconnect to free up resources
				//then reconnect
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
		
		private function onCameraStatus( evt:StatusEvent ):void {
			if (evt.code == "Camera.Muted"){
				showAlert("Camera Access Has Been Denied! You have to reload to enable camera in flash settings!");
			}
			if (evt.code == "Camera.Unmuted"){
				//Alert.show("Camera Access Has Been Granted", "Information");
			}
		}
		private function onMicStatus(evt:StatusEvent):void {
			switch (evt.code) {
				case "Microphone.Unmuted":
					//Alert.show("Camera Access Has Been Granted!", "Information");
					break;
				case "Microphone.Muted":
					showAlert("Microphone Access Has Been Denied! You have to reload to enable microphone in flash settings!");
					break;
			}
		}
		
		private function getPublisherName():String {
			var publisherName:String;
			//find the publishDest
			for each(var item:String in dataSet){
				var bFound:Boolean = false;
				var length:uint = publishedStreamArray.length;
				for ( var i:uint=0; i<length; i++ ) {
					//check if the stream is already published
					if (publishedStreamArray[ i ] == item ) {
						bFound = true;
						break;
					}
				}
				if( !bFound) {
					publisherName = item;
					break;
				}
			}
			//logDebug("----publisherName="+publisherName);
			return publisherName;
		}
		
		private function attachCamera():void {
			camera = delegate_.tryGetFrontCamera();	     
			if (camera == null) {
				logDebug("----camera null");
				Security.showSettings(SecurityPanel.CAMERA) ;
			} else {
				camera.addEventListener(StatusEvent.STATUS, onCameraStatus);
				camera.setMode(delegate_.getVideoWidth(), delegate_.getVideoHeight(), 30); //640*480 30 fps
				camera.setQuality(16384,0); //0% quality, 16kBytes/sec bw limitation
				streamPub.attachCamera(camera);
				videoSelf.attachCamera(camera);
			}
		}
		private function detachCamera():void {			
			if( camera ) {
				camera.removeEventListener(StatusEvent.STATUS, onCameraStatus);
				streamPub.attachCamera(null);
				videoSelf.attachCamera(null);
			}
		}
		
		private function publishNow() : void {
			//already published, don't do anything.
			if( publishDest!=null) {
				return;
			}
			publishDest = getPublisherName();
			logDebug("----publishDest="+publishDest);
			try{
				isViewOnly_ = (publishDest == null);
				if( isViewOnly_ ) {
					//logDebug("----cannot join, view only!");
					openViewStream( allinone );
					return;
				}
				openViewStream( publishDest );
				
				//logDebug("----try to open microphone");
				mic = Microphone.getMicrophone();
				if (mic == null) {
					logDebug("----mic null");
					Security.showSettings(SecurityPanel.MICROPHONE) ;
				} else {
					mic.addEventListener(StatusEvent.STATUS, onMicStatus);
					
					streamPub = new NetStream(netConn);
					videoSelf = new Video();
					attachCamera();	
					
					var h264settings:H264VideoStreamSettings = new H264VideoStreamSettings(); 
					h264settings.setProfileLevel(H264Profile.BASELINE, H264Level.LEVEL_1_2);
					streamPub.videoStreamSettings = h264settings; 
					streamPub.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
					streamPub.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
					streamPub.publish(publishDest, "live");
					
					videoSelf.x = delegate_.getScreenX();
					videoSelf.y = delegate_.getScreenY();
					videoSelf.width = delegate_.getScreenWidth()-2*delegate_.getScreenX();
					videoSelf.height = delegate_.getScreenHeight()-2*delegate_.getScreenY();
					videoSelf.visible = true;
					container_.addChildAt(videoSelf, container_.getChildIndex(videoOthers));
					
					mic.setSilenceLevel(0,200);
					//Speex settings
					mic.encodeQuality = 10; //best quality
					mic.codec = SoundCodec.SPEEX; 
					mic.framesPerPacket = 1; //20ms per frame, instead of 40ms per frame
					
					mic.setLoopBack(false);
					mic.setUseEchoSuppression(true);
					
					//detectLoopback();
					//detectVolume();
					streamPub.attachAudio(mic);
					//Alert.show("camera width="+camera.width);
				}				
			} catch(e:Error) {
				logDebug("---Exception="+e);
			}
		}
		
		private function closePublishStream():void {
			if( mic ) {
				mic.removeEventListener(StatusEvent.STATUS, onMicStatus);
				streamPub.attachAudio(null);
			}
			detachCamera();
			if( videoSelf ) {
				videoSelf.attachCamera(null);
				videoSelf.clear();
				container_.removeChild(videoSelf);
				videoSelf = null;
			}
			if( streamPub ) {
				streamPub.dispose();
				streamPub.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				streamPub.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
				streamPub.close();
				streamPub = null;
			}
			publishDest = null;
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetStream.Play.StreamNotFound":
					logDebug("Unable to locate video: " + publishDest);
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
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			logDebug("securityErrorHandler: " + event);
		}
		
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			// ignore AsyncErrorEvent events.
		}
		
		private function disconnectStreams():void {
			//TODO
		}
		
		private function openViewStream(dest:String):void {
			streamView = new NetStream(netConn);
			
			streamView.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			streamView.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			
			var cliente:Object = new Object();
			cliente.onCuePoint = this.onCuePoint;
			streamView.client = cliente;
			streamView.bufferTime = 0;
			streamView.bufferTimeMax = 0;
			//causes android to fail for unknown reason, anyway, this flag is not helping too much.
			//streamView.useJitterBuffer = true; //audio is mp3, so set buffer to be 0 
			streamView.play(mixedStreamPrefix + dest);
			
			videoOthers = new Video();
			videoOthers.attachNetStream(streamView);
			container_.addChild(videoOthers);
			//video.opaqueBackground = 0x000000;
			videoOthers.x = delegate_.getScreenX();
			videoOthers.y = delegate_.getScreenY();
			videoOthers.width = (delegate_.getScreenWidth() - 2 * delegate_.getScreenX());
			videoOthers.height = (delegate_.getScreenHeight() - 2 * delegate_.getScreenY());
			videoOthers.visible = true;
		}
		
		private function closeViewStream():void {
			if( videoOthers && container_.contains(videoOthers) ) {
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
		}
		
		private function onCuePoint(info:Object):void {
			var x:int = 0;
			var y:int = 0;
			var width:int = 0;
			var height:int = 0;
			for (var propName:String in info) {
				if (propName != "parameters") {
					//logDebug(propName + " = " + info[propName]);
					if( propName == "x" ) {
						x = info[propName];
					} else if( propName == "y" ) {
						y = info[propName];
					} else if( propName == "width" ) {
						width = info[propName];
					} else if( propName == "height" ) {
						height = info[propName];
					}
				}
			}
			
			videoSelf.x = ((x*(delegate_.getScreenWidth()-2*delegate_.getScreenX()))/delegate_.getVideoWidth()) + delegate_.getScreenX();
			videoSelf.y = ((y*(delegate_.getScreenHeight()-2*delegate_.getScreenY()))/delegate_.getVideoHeight()) + delegate_.getScreenY();
			videoSelf.width = (width*(delegate_.getScreenWidth()-2*delegate_.getScreenX()))/delegate_.getVideoWidth();
			videoSelf.height = (height*(delegate_.getScreenHeight()-2*delegate_.getScreenY()))/delegate_.getVideoHeight();
			/*
			logDebug("videoSelf.x = " + videoSelf.x);
			logDebug("videoSelf.y = " + videoSelf.y);
			logDebug("videoSelf.width = " + videoSelf.width);			
			logDebug("videoSelf.height = " + videoSelf.height);
			*/
			
			container_.addChild(videoOthers);
			container_.addChildAt(videoSelf, container_.getChildIndex(videoOthers));
		};
		//server call to client
		private function newStream(publishedStream:String):void {
			if( publishedStreamArray.indexOf(publishedStream) == -1 && 
				publishedStream.indexOf(mixedStreamPrefix) < 0 && 
				publishedStream != publishDest ){ 
				logDebug(publishedStream+" joined!");
				publishedStreamArray.push(publishedStream);
			}
		}
		private function removeElementFromStringVector(element:String, vector:Vector.<String>):void {  
			if(vector.indexOf(element) > -1){  
				vector.splice(vector.indexOf(element), 1);  
				removeElementFromStringVector(element, vector);
				//Alert.show("An old connection "+element+" left", "Information");  
			} else {  
				return;  
			}  
		}  
		private function delayedFunctionCall(delay:int, func:Function):void {
			//trace('going to execute the function you passed me in', delay, 'milliseconds');
			var timer:Timer = new Timer(delay, 1);
			timer.addEventListener(TimerEvent.TIMER, func);
			timer.start();
		}
		
		public function initStreams(resp:Object):void {
			var streamListStr:String = String(resp);
			logDebug("initStreams = "+streamListStr+"---"); 
			if( streamListStr != "") {
				var streamListArr:Array = streamListStr.split(",");
				var arrLen:int = streamListArr.length;
				for (var i:int = 0; i<arrLen; i++) {
					newStream(streamListArr[i]);
				}
			}
		}
		public function detectEmptyStream():void {
			var onResult:Function = function (result:Object):void {
				var isEmpty:Boolean = Boolean(result);
				logDebug("isEmpty = "+isEmpty+"---"); 
			}
			// Create a responder object
			var myResult:Responder = new Responder( onResult );
			// Create an onResult( ) method to handle results from the call to the remote method
			netConn.call("clientRequest.isEmptyStream", myResult);
		}
		public function addStream(resp:Object):void {
			newStream(String(resp));
		}
		public function removeStream(resp:Object):void {
			removeElementFromStringVector(String(resp), publishedStreamArray);
		}
		
		override public function selectVideo(videoName:String):void {
			if( publishDest != null ) {
				netConn.call("clientRequest.selectVideo", null, videoName);	
			}
		}
		override public function stopVideo():void {
			if( publishDest != null ) {
				netConn.call("clientRequest.selectVideo", null, defaultVideo);	
			}
		}
		
		//notify external video is playing
		public function onVideoSelected(resp:Object):void	
		{
			var videoName:String = String(resp);
			if( videoName != null) {
				delegate_.onVideoSelected(videoName);
			}
		}
		public function onVideoListPopulated(resp:Object):void	{
			var videoListStr:String = String(resp);
			//logDebug("videoPopulated = "+videoListStr);
			if( videoListStr != "") {
				var videoNamesArray:Array = videoListStr.split(",");
				delegate_.onVideoListPopulated(videoNamesArray);	
			}
		}
		
		override public function isViewOnly():Boolean {
			return isViewOnly_;
		}
		override public function switchToViewOnly(forceViewOnly:Boolean):void {
			if( forceViewOnly ) {
				if( !isViewOnly_ ) {
					closeViewStream();
					closePublishStream();
					isViewOnly_ = true;
					openViewStream( allinone );
					//detect whether empty room or not after 1 second
					delayedFunctionCall(1000, function(e:Event):void {detectEmptyStream();});
				} else {
					//do nothing
				}
			} else {
				if( isViewOnly_ && getPublisherName() != null ) {
					closeViewStream();
					publishNow();					
				} else {
					//do nothing
				}
			}
		}
		
		override public function isAudioOnly():Boolean {
			return isAudioOnly_;
		}
		override public function switchToAudioOnly(forceAudioOnly:Boolean):void {	
			if( forceAudioOnly ) {
				if( !isAudioOnly_ ) {
					detachCamera();
					isAudioOnly_ = true;
				} else{
					//do nothing
				}
			} else {
				if( isAudioOnly_ ) {
					attachCamera();
					isAudioOnly_ = false;
				} else {
					//do nothing
				}
			}
		}
	}
}