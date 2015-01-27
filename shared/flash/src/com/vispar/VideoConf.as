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
		private var defaultSong:String = "Default"; //default song means mtv stopped
		
		private var publishDest:String = null;
		private var publishedStreamArray:Vector.<String> = new Vector.<String>();
		
		private var videoSelf:Video = null;
		private var videoOthers:Video = null;
		
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
				logDebug(" null!");				
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
			if( mic ) {
				mic.removeEventListener(StatusEvent.STATUS, onMicStatus);
			}
			if( camera ) {
				camera.removeEventListener(StatusEvent.STATUS, onCameraStatus);
			}
			if( videoSelf ) {
				videoSelf.attachCamera(null);
				videoSelf.clear();
				container_.removeChild(videoSelf);
				videoSelf = null;
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
			if( streamPub ) {
				streamPub.dispose();
				streamPub.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				streamPub.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
				streamPub.close();
				streamPub = null;
			}
			if( netConn ) {
				netConn.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);			
				netConn.removeEventListener(NetStatusEvent.NET_STATUS, onConnectionNetStatus);
				netConn.close();
				netConn = null;
			}
			logDebug("=>disconnect from server!");
			
			publishDest = null;
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
				//Alert.show("Camera Access Has Been Denied!", "Information");
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
					logDebug("Camera Access Has Been Denied!");
					break;
			}
		}
		
		private function publishNow() : void {
			
			//already published, don't do anything.
			if( publishDest!=null) {
				return;
			}
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
					publishDest = item;
					break;
				}
			}
			logDebug("----publishNow, publishDest="+publishDest);
			
			try{
				openViewStream();
				
				if( publishDest == null ) {
					//Alert.show("Cannot only listen to karaoke, since the room is already full!", "Information");
					return;
				}
				camera = delegate_.tryGetFrontCamera();	     
				if (camera == null) {
					logDebug("----camera null");
					Security.showSettings(SecurityPanel.CAMERA) ;
				} else{
					logDebug("----try to open microphone");
					mic = Microphone.getMicrophone();
					mic.addEventListener(StatusEvent.STATUS, onMicStatus);
					camera.addEventListener(StatusEvent.STATUS, onCameraStatus);
					camera.setMode(delegate_.getVideoWidth(), delegate_.getVideoHeight(), 30); //640*480 30 fps
					camera.setQuality(16384,0); //0% quality, 16kBytes/sec bw limitation
					
					streamPub = new NetStream(netConn);
					var h264settings:H264VideoStreamSettings = new H264VideoStreamSettings(); 
					h264settings.setProfileLevel(H264Profile.BASELINE, H264Level.LEVEL_1_2);
					streamPub.videoStreamSettings = h264settings; 
					streamPub.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
					streamPub.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
					streamPub.attachCamera(camera);
					streamPub.publish(publishDest, "live");
					
					videoSelf = new Video();
					videoSelf.attachCamera(camera) ;
					container_.addChildAt(videoSelf, container_.getChildIndex(videoOthers));
					videoSelf.x = delegate_.getScreenX();
					videoSelf.y = delegate_.getScreenY();
					videoSelf.width = (delegate_.getScreenWidth()-2*delegate_.getScreenX())/2;
					videoSelf.height = delegate_.getScreenHeight()/2;
					videoSelf.visible = true;
					
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
		
		private function openViewStream():void {
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
			streamView.play(mixedStreamPrefix + publishDest);
			
			videoOthers = new Video();
			videoOthers.attachNetStream(streamView);
			container_.addChild(videoOthers);
			//video.opaqueBackground = 0x000000;
			videoOthers.width = (delegate_.getScreenWidth() - 2*delegate_.getScreenX());
			videoOthers.height = delegate_.getScreenHeight();
			videoOthers.x = delegate_.getScreenX();
			videoOthers.y = delegate_.getScreenY();
			videoOthers.visible = true;
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
			
			videoSelf.x = (x*(delegate_.getScreenWidth()-2*delegate_.getScreenX()))/delegate_.getVideoWidth() + delegate_.getScreenX();
			videoSelf.y = (y*delegate_.getScreenHeight())/delegate_.getVideoHeight();
			videoSelf.width = (width*(delegate_.getScreenWidth()-2*delegate_.getScreenX()))/delegate_.getVideoWidth();
			videoSelf.height = (height*delegate_.getScreenHeight())/delegate_.getVideoHeight();
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
				logDebug("A new connection "+publishedStream+" joined");
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
			logDebug("initStreams = "+streamListStr); 
			if( streamListStr != "") {
				var streamListArr:Array = streamListStr.split(",");
				var arrLen:int = streamListArr.length;
				for (var i:int = 0; i<arrLen; i++) {
					newStream(streamListArr[i]);
				}
			}
		}
		public function addStream(resp:Object):void {
			newStream(String(resp));
		}
		public function removeStream(resp:Object):void {
			removeElementFromStringVector(String(resp), publishedStreamArray);
		}
	}
}