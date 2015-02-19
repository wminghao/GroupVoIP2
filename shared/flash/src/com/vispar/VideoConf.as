package com.vispar
{
	import com.vispar.network.LowPlaybackBWDetector;
	import com.vispar.network.LowPublishBWDetector;
	import com.vispar.network.NetworkDisconnectDetector;
	
	import flash.display.*;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import org.red5.flash.bwcheck.events.BandwidthDetectEvent;
	
	public class VideoConf extends VideoContainer
	{
		private var streamPub:NetStream = null; //must declare outside, otherwise, gc will recycle it.
		private var streamView:NetStream = null; //must declare outside
		//netconnection
		private var netConn:NetConnection = null;	
		
		private var mic:Microphone = null;
		private var camera:Camera = null;
		
		private const mixedStreamPrefix:String = "__mixed__";
		private const appName:String = "VisparApp";
		private const defaultVideo:String = "Default"; //default means video stopped
		private const allinone:String = "allinone";
		private const maxPublishers:int = 9; //including the external video
		private var totalPublishers:int = 0;
		
		private var publishDest:String = null;
		private var publishedStreamArray:Vector.<String> = new Vector.<String>();
		private var audioOnlyPublisherArray:Vector.<String> = new Vector.<String>();
		
		private var videoSelf:Video = null;
		private var videoOthers:Video = null;
		
		private var isViewOnly_:Boolean = false;
		private var isAudioOnly_:Boolean = false;
		
		//detect connection timeout
		private var connTimeoutTimer:Timer = null;
		private var reconnTimer:Timer = null; 
		
		//detect low bw
		private var lowPlaybackBWDetector_:LowPlaybackBWDetector = new LowPlaybackBWDetector(stopVideoCallbackOnLowBW, logDebug);
		private var lowPublishBWDetector_:LowPublishBWDetector = new LowPublishBWDetector(stopVideoCallbackOnLowBW, logDebug);
		private var networkDisconnectDetector_:NetworkDisconnectDetector = new NetworkDisconnectDetector(stopVideoCallbackOnLowBW);
		private var uploadSpeedTimer:Timer = null;
		
		private var emptyRoomNotification_:TextField = null;
		private var emptyRoomNotificationButton_ : Sprite = null;
		
		private var fatalError_:Boolean = false;
		private var bOnVideoListPopulated_:Boolean = false;
		private var bOnVideoPlaybackStarted_:Boolean = false;
		
		private const AUDIO_ON_FLAG:int = 0x1;
		private const VIDEO_ON_FLAG:int = 0x2;
		
		public function VideoConf(container:Sprite, delegate:VideoContainerDelegate, room:String, user:String, mode:String, forceAudioOnly:Boolean, autoPublish:Boolean)
		{ 
			super(container, delegate, room, user, mode, forceAudioOnly, autoPublish);
			
			if( forceAudioOnly ) {
				isAudioOnly_ = true;
			}
		}
		
		private function getVideoPath():String{
			return "rtmp://"+serverIp+"/"+appName+"/"+room;
		}
		
		override public function connectServer():void {
			if( netConn == null) {
				//logDebug(" null!");				
			}			
			
			var videoPath:String = getVideoPath();
			// setup connection code
			netConn = new NetConnection();
			netConn.connect(videoPath);
			netConn.addEventListener(NetStatusEvent.NET_STATUS, onConnectionNetStatus);
			netConn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			netConn.client = this;
			
			logDebug("=>connect 2 server!");
			connTimeoutTimer = new Timer(3000, 1);
			connTimeoutTimer.addEventListener(TimerEvent.TIMER, onReconnectTimer);
			connTimeoutTimer.start();
		}
		
		override public function disconnectServer():void {
			stopReconnTimer();
			stopConnTimeoutTimer();
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
			audioOnlyPublisherArray = new Vector.<String>();
		}
		
		private function onConnectionNetStatus(event:NetStatusEvent) : void {
			stopConnTimeoutTimer();			
			stopReconnTimer();
			// did we successfully connect
			if(event.info.code == "NetConnection.Connect.Success") {
				netConn.call("clientRequest.setAsUser", null, user, 
														(!isAutoMode()  && (room == user)));	
				if( room == user || autoPublish_ ) {
					delayedFunctionCall(1000, function(e:Event):void { 
						publishNow();
						delegate_.onVideoStarted( isViewOnly_);
						//logDebug("NetConnection.Connect.Success!");
					});
				} else {
					openViewStream( allinone );
					isViewOnly_ = true;
					delegate_.onVideoStarted( isViewOnly_ );
					delayedFunctionCall(1000, function(e:Event):void {detectEmptyStream();});
				}
				networkDisconnectDetector_.onConnectNotification();
			} else if(event.info.code == "NetConnection.Connect.Failed" ||
					  event.info.code == "NetConnection.Connect.IdleTimeout" ||
					  event.info.code == "NetConnection.Connect.Closed"){
				logDebug("Connection code:"+event.info.code+", try reconnecting");
				disconnectServer(); //disconnect to free up resources
				reconnTimer = new Timer(3000, 1);
				reconnTimer.addEventListener(TimerEvent.TIMER, onReconnectTimer);
				reconnTimer.start();	
			} else if(event.info.code == "NetConnection.Connect.Rejected" ||
					  event.info.code == "NetConnection.Connect.AppShutdown") {
				logDebug("Connection code:"+event.info.code+". Fatal error");
				disconnectServer();
				showEmptyNotification("Fatal Error, Server Side. Sorry for the trouble, please try again!");
			} else {
				logDebug("Connection code:"+event.info.code+". Ignore event");
			}
		}
		private function onReconnectTimer(e:TimerEvent):void
		{
			showEmptyNotification("Network failed! Reconnecting now!");
			try {
				//then reconnect
				var shouldReconn:Boolean = networkDisconnectDetector_.onDisconnectNotification();
				disconnectServer();
				if( shouldReconn ) {
					connectServer();
				}
			} catch(e:Error) {
				logDebug("---Exception="+e);
			}
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
		
		private function getPublisherName():Array {
			var publisherName:String = null;
			var bFound:Boolean = false;
			if( totalPublishers < maxPublishers ) {
				//find the publishDest
				var length:uint = publishedStreamArray.length;
				for ( var i:uint=0; i<length; i++ ) {
					//check if the stream is already published
					if (publishedStreamArray[ i ] == this.user ) {
						bFound = true;
						break;
					}
				}
				if( !bFound ) {
					publisherName = this.user;
				}
			}
			return [publisherName, bFound];
		}
		
		private function attachCamera():void {
			camera = delegate_.tryGetFrontCamera();	     
			if (camera == null) {
				logDebug("----camera null");
				Security.showSettings(SecurityPanel.CAMERA) ;
			} else {
				videoSelf = new Video();
				camera.addEventListener(StatusEvent.STATUS, onCameraStatus);
				camera.setMode(delegate_.getVideoWidth(), delegate_.getVideoHeight(), 30); //640*480 30 fps
				camera.setQuality(16384*2,0); //0% quality, 16kBytes/sec bw limitation
				streamPub.attachCamera(camera);
				videoSelf.attachCamera(camera);
				
				videoSelf.x = delegate_.getScreenX();
				videoSelf.y = delegate_.getScreenY();
				videoSelf.width = delegate_.getScreenWidth()-2*delegate_.getScreenX();
				videoSelf.height = delegate_.getScreenHeight()-2*delegate_.getScreenY();
				videoSelf.visible = true;
				container_.addChildAt(videoSelf, container_.getChildIndex(videoOthers));
			}
		}
		private function detachCamera():void {			
			if( camera ) {
				camera.removeEventListener(StatusEvent.STATUS, onCameraStatus);
				streamPub.attachCamera(null);
				camera = null;
			}
			if( videoSelf ) {
				videoSelf.attachCamera(null);
				videoSelf.clear();
				container_.removeChild(videoSelf);
				videoSelf = null;
			}
		}
		
		private function publishNow() : void {
			//already published, don't do anything.
			if( publishDest!=null) {
				return;
			}
			var ret:Array = getPublisherName();
			try{
				publishDest = ret[0];
				isViewOnly_ = (publishDest == null);
				logDebug("----publishDest="+publishDest);
				if( isViewOnly_ ) {
					openViewStream( allinone );
					if( ret[1] == true ) {
						showAlert("Cannot join b/c you have logged on from a different client, viewer mode only now!");						
					} else {
						showAlert("Cannot join b/c it exceeds max talker's capacity, viewer mode only now!");
					}
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
					//if it's audio only mode, don't attach camera
					if( !isAudioOnly_ ) {
						attachCamera();	
					}					
					var h264settings:H264VideoStreamSettings = new H264VideoStreamSettings(); 
					h264settings.setProfileLevel(H264Profile.BASELINE, H264Level.LEVEL_1_2);
					streamPub.videoStreamSettings = h264settings; 
					streamPub.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
					streamPub.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
					streamPub.publish(publishDest, "live");
					
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
					
					addStreamToStringVector(publishDest);
					
					//initiate the speed test
					this.initBWEstimator( getVideoPath(), startUploadSpeedTimer );
					
					//tell the server it's in audio mode or av mode.
					netConn.call("clientRequest.switchAVFlag", null, isAudioOnly_?AUDIO_ON_FLAG:(AUDIO_ON_FLAG | VIDEO_ON_FLAG));
				}				
			} catch(e:Error) {
				logDebug("---Exception="+e);
			}
		}
		
		private function closePublishStream():void {
			if( mic ) {
				mic.removeEventListener(StatusEvent.STATUS, onMicStatus);
				streamPub.attachAudio(null);
				mic = null;
			}
			detachCamera();
			if( streamPub ) {
				streamPub.dispose();
				streamPub.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				streamPub.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
				streamPub.close();
				streamPub = null;
			}
			if( publishDest ) {
				removeElementFromStringVector(publishDest, publishedStreamArray);
				publishDest = null;
			}
			stopUploadSpeedTimer();
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
				case "NetStream.Play.InsufficientBW": //playback only
					lowPlaybackBWDetector_.onLowBWNotification();
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
			
			if( videoOthers != null ) {
				container_.addChild(videoOthers);
			}
			if( videoSelf != null ) {
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
				
				container_.addChildAt(videoSelf, container_.getChildIndex(videoOthers));
			}
		};
		//server call to client
		private function addStreamToStringVector(publishedStream:String):void {
			if( publishedStreamArray.indexOf(publishedStream) == -1 && 
				publishedStream.indexOf(mixedStreamPrefix) < 0 ){ 
				totalPublishers++;
				logDebug(publishedStream+" joined="+totalPublishers+"!");
				publishedStreamArray.push(publishedStream);
				removeEmptyNotification();
			}
		}
		private function removeElementFromStringVector(element:String, vector:Vector.<String>):void {  
			if(vector.indexOf(element) > -1){  
				vector.splice(vector.indexOf(element), 1);
				totalPublishers--;
				logDebug(element+" removed="+totalPublishers+"!");
				//detect whether empty room or not after 1 second
				if( !fatalError_ ) {
					delayedFunctionCall(1000, function(e:Event):void {detectEmptyStream();});
				}
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
			//logDebug("initStreams = "+streamListStr+"---"); 
			if( streamListStr != "") {
				var streamListArr:Array = streamListStr.split(",");
				var arrLen:int = streamListArr.length;
				for (var i:int = 0; i<arrLen; i++) {
					addStreamToStringVector(streamListArr[i]);
				}
			}
		}
		public function initAudioOnlyStreams(resp:Object):void {
			var streamListStr:String = String(resp);
			//logDebug("audioOnlyPublisherArray = "+streamListStr+"---"); 
			if( streamListStr != "") {
				var streamListArr:Array = streamListStr.split(",");
				var arrLen:int = streamListArr.length;
				for (var i:int = 0; i<arrLen; i++) {
					audioOnlyPublisherArray.push(streamListArr[i]);
				}
				//detect all audio stream
				delayedFunctionCall(1000, function(e:Event):void {detectAllAudioOnly();});
			}
		}
		private function removeEmptyNotification():void {
			//remove the notification
			if( emptyRoomNotification_!=null && container_.contains(emptyRoomNotification_)) {
				container_.removeChild(emptyRoomNotification_);
			}			
			if( emptyRoomNotificationButton_!=null && container_.contains(emptyRoomNotificationButton_)) {
				container_.removeChild(emptyRoomNotificationButton_);
			}			
		}
		private function showEmptyNotification(message:String):void {
			if( videoOthers ) {
				videoOthers.clear();
			}
			//remove the notification
			if( emptyRoomNotification_!=null && container_.contains(emptyRoomNotification_)) {
				container_.removeChild(emptyRoomNotification_);
			}
			emptyRoomNotification_ = new TextField();
			emptyRoomNotification_.width = (delegate_.getScreenWidth() - 2 * delegate_.getScreenX())/2;
			emptyRoomNotification_.height = (delegate_.getScreenHeight() - 2 * delegate_.getScreenY())/2;
			emptyRoomNotification_.x = delegate_.getScreenX() + emptyRoomNotification_.width/2 - 100;
			emptyRoomNotification_.y = delegate_.getScreenY() + emptyRoomNotification_.height/2 - 20;
			var format:TextFormat = new TextFormat();
			format.bold = true;
			format.size = 30;
			format.color = 0x0000FF;
			emptyRoomNotification_.defaultTextFormat = format;
			emptyRoomNotification_.background = true; 
			emptyRoomNotification_.backgroundColor = 0xFFF000; 
			emptyRoomNotification_.text = message;
			emptyRoomNotification_.border = true;
			emptyRoomNotification_.wordWrap = true;
			container_.addChild(emptyRoomNotification_);
			
			/*
			function dismissEmptyRoomNotificationHandler(eventType : String) : void {
				try {
					removeEmptyNotification();
				} catch(err:Error) {
					logDebug(err.toString());
				}
			}
			try {
				var textField:TextField = new TextField();
				textField.defaultTextFormat = format;
				textField.text = "OK";
				emptyRoomNotificationButton_ = new Sprite();
				emptyRoomNotificationButton_.width = 120;
				emptyRoomNotificationButton_.height = 28;
				const g:Graphics = emptyRoomNotificationButton_.graphics;
				g.clear();
				g.lineStyle(1, 0x0000CC);   
				g.beginFill(0x0000FF);
				g.drawCircle(0, 0, 40);
				g.endFill();
				emptyRoomNotificationButton_.addChild(textField);
				emptyRoomNotificationButton_.addEventListener(MouseEvent.MOUSE_DOWN, function(event:MouseEvent) : void {
					dismissEmptyRoomNotificationHandler(event);
				});
				container_.addChild(emptyRoomNotificationButton_);
			} catch(err:Error) {
				logDebug(err.toString());
			}
			*/
		}
		
		public function detectAllAudioOnly():void {
			var bAllAudioOnly:Boolean = true;
			var length:uint = publishedStreamArray.length;
			for ( var i:uint=0; i<length; i++ ) {
				//check if the stream is already published
				if ( audioOnlyPublisherArray.indexOf( publishedStreamArray[ i ]) == -1 ) {
					bAllAudioOnly = false;
					//logDebug(publishedStreamArray[ i ]+" not audio only");
					break;
				}
			}
			if( bAllAudioOnly && !bOnVideoPlaybackStarted_ ) {
				showEmptyNotification("All talkers are in audio only mode!");						
			} else {
				removeEmptyNotification();
			}
		}
		
		public function detectEmptyStream():void {
			var onResult:Function = function (result:Object):void {
				var isEmpty:Boolean = Boolean(result);
				if( isEmpty ) {
					showEmptyNotification("You are in viewer mode. There is no body joining the session right now.\n\n" +
						"You can either go to talker mode or wait until others join!");
				} else {
				}
			}
			// Create a responder object
			var myResult:Responder = new Responder( onResult );
			// Create an onResult( ) method to handle results from the call to the remote method
			netConn.call("clientRequest.isEmptyStream", myResult);
		}
		public function addStream(resp:Object):void {
			addStreamToStringVector(String(resp));
		}
		public function removeStream(resp:Object):void {
			removeElementFromStringVector(String(resp), publishedStreamArray);
		}
		override public function selectExternalVideo(videoName:String):void {
			if( publishDest != null ) {
				netConn.call("clientRequest.selectExternalVideo", null, videoName);	
			}
		}
		override public function stopExternalVideo():void {
			if( publishDest != null ) {
				netConn.call("clientRequest.stopExternalVideo", null);	
			}
		}
		
		//notify external video is playing
		public function onExternalVideoPlaying(resp:Object):void	
		{
			var videoName:String = String(resp);
			if( videoName != null) {
				delegate_.onExternalVideoPlaying(videoName);
			}
		}
		public function onExternalVideoStarted():void	
		{		
			if( !bOnVideoPlaybackStarted_ ) {
				totalPublishers++; //consider an external video as one of the publishers
				delegate_.onExternalVideoStarted();
				logDebug(" totalPublishers="+totalPublishers+"!");
				bOnVideoPlaybackStarted_ = true;
			}
		}
		public function onExternalVideoStopped():void	
		{
			if( bOnVideoPlaybackStarted_ ) {
				totalPublishers--; //consider an external video as one of the publishers
				delegate_.onExternalVideoStopped();
				logDebug(" totalPublishers="+totalPublishers+"!");
				bOnVideoPlaybackStarted_ = false;
			}
		}
		public function onExternalVideoListPopulated(resp:Object):void	{
			//only populate video list once for now.TODO make it dynamic in the future.
			if( !bOnVideoListPopulated_ ) {
				var videoListStr:String = String(resp);
				//logDebug("videoPopulated = "+videoListStr);
				if( videoListStr != "") {
					var videoNamesArray:Array = videoListStr.split(",");
					delegate_.onExternalVideoListPopulated(videoNamesArray);	
				}
				bOnVideoListPopulated_ = true;
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
					delegate_.onVideoStarted( isViewOnly_ );
				} else {
					//do nothing
				}
			} else {
				var isInAutoMode:Boolean = isAutoMode();
				if( !isInAutoMode && totalPublishers == 0 ) {
					delegate_.showAlert("There is no moderator!");
				} else if( isViewOnly_ ) {		
					if( isInAutoMode || ( room == user ) ){
						onRequest2TalkApproved(true); //join immediately
					} else {
						request2Talk(); //requesting moderator to join the talk
					}
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
					netConn.call("clientRequest.switchAVFlag", null, isAudioOnly_?AUDIO_ON_FLAG:(AUDIO_ON_FLAG | VIDEO_ON_FLAG));
				} else{
					//do nothing
				}
			} else {
				if( isAudioOnly_ ) {
					attachCamera();
					isAudioOnly_ = false;
					netConn.call("clientRequest.switchAVFlag", null, isAudioOnly_?AUDIO_ON_FLAG:(AUDIO_ON_FLAG | VIDEO_ON_FLAG));
				} else {
					//do nothing
				}
			}
		}
		
		private function stopReconnTimer():void {
			if( reconnTimer ) {
				reconnTimer.stop();
				reconnTimer = null;
			}
		}
		private function stopConnTimeoutTimer():void {
			if( connTimeoutTimer ) {
				connTimeoutTimer.stop();
				connTimeoutTimer = null;
			}
		}
		
		//uplink network speed test
		private function startUploadSpeedTimer():void {
			uploadSpeedTimer = new Timer(2000);
			uploadSpeedTimer.addEventListener(TimerEvent.TIMER, onUploadSpeedDetected);
			uploadSpeedTimer.start();
			logDebug("--Started BW estimator");
		}
		private function stopUploadSpeedTimer():void{
			if( uploadSpeedTimer ) {
				uploadSpeedTimer.stop();
				uploadSpeedTimer = null;
			}
			stopBWEstimator();
		}
		private function onUploadSpeedDetected(e:TimerEvent):void
		{
			//periodically detect upload speed
			uploadSpeedTest();
		}
		
		override protected function onClientServerComplete(event:BandwidthDetectEvent):void
		{			
			//logDebug("\n\n kbitUp = " + event.info.kbitUp + ", deltaUp= " + event.info.deltaUp + ", deltaTime = " + event.info.deltaTime + ", latency = " + event.info.latency + " KBytes " + event.info.KBytes);
			this.lowPublishBWDetector_.onPublishBWDetected(event.info.kbitUp);
		}
		
		//stop video if either uplink speed or downlink speed is too bad
		private function stopVideoCallbackOnLowBW(isAudioOnlyMode:Boolean, str:String):void {
			this.delegate_.onFatalNetworkTooSlowError(isAudioOnlyMode);	
			if( isAudioOnlyMode ) {
				switchToAudioOnly( true );
				delegate_.showAlert("Your network upload speed is too slow, we have to shut off video and switch to audio only mode!");
			} else {
				fatalError_ = true;
				closeViewStream();
				closePublishStream();
				showEmptyNotification("Your video has to stop now since your "+str+ " speed is either slow or unstable.\n\n" +
					"Please make sure you have a reliable network of at least 1Mbps uplink and downlink speed for best service!");		
			}
		}
		
		//approval mode
		public function request2Talk():void{
			netConn.call("clientRequest.request2Talk", null, user);	
			delegate_.onRequest2TalkPendingApproval( true );
		}
		public function onRequest2TalkApproved(resp:Object):void{
			var isAllow:Boolean = Boolean(resp);
			logDebug(" onRequest2TalkApproved! isAllow="+isAllow);
			if( isAllow ) {
				closeViewStream();
				publishNow();		
			} else {
				delegate_.showAlert("Request denied to join the conversation!");
			}
			delegate_.onRequest2TalkPendingApproval( false );
			delegate_.onVideoStarted( isViewOnly_ );
		}
		public override function approveRequest2Talk(isAllow:Boolean, user:String):void {
			logDebug(" approveRequest2Talk user="+user+" isAllow="+isAllow);
			netConn.call("clientRequest.approveRequest2Talk", null, isAllow, user);	
		}
		public function onRequest2TalkNeedsApproval(resp:Object):void{
			var user:String = String(resp);
			delegate_.onRequest2TalkNeedsApproval(user);
		}
		public function onUserJoinedTalk(resp1:Object, resp2:Object):void {
			try {
				var user:String = String(resp1);
				var avFlag:int = int(resp2);
				delegate_.onUserJoinedTalk(user, avFlag);
				if( avFlag == AUDIO_ON_FLAG ) {
					audioOnlyPublisherArray.push(user);
				} else {
					audioOnlyPublisherArray.splice(audioOnlyPublisherArray.indexOf(user), 1);					
				}
				//detect all audio stream
				delayedFunctionCall(1000, function(e:Event):void {detectAllAudioOnly();});
			} catch(e:Error) {
				logDebug("---onUserJoinedTalk Exception="+e);
			}
		}
	}
}