package
{
	import com.wadedwalker.nativeExtension.telephone.CallStateEvent;
	import com.wadedwalker.nativeExtension.telephone.DataActivityEvent;
	import com.wadedwalker.nativeExtension.telephone.DataConnectionStateEvent;
	import com.wadedwalker.nativeExtension.telephone.TelephoneManager;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import mx.controls.Alert;
	
	public class airconf extends Sprite
	{
		private var streamPub:NetStream = null; //must declare outside, otherwise, gc will recycle it.
		private var streamView:NetStream = null; //must declare outside
		
		private var netConn:NetConnection = null;	
		private var mic:Microphone = null;
		private var camera:Camera = null;
		
		private var serverIp:String = "54.201.108.66";//"192.168.2.109";//"192.168.0.61";
		private var mixedStreamPrefix:String = "__mixed__";
		private var defaultSong:String = "Default"; //default song means mtv stopped
		
		private var publishDest:String = null;
		private var publishedStreamArray:Vector.<String> = new Vector.<String>();
		
		private var videoWidth:int = 640;
		private var videoHeight:int = 480;
		
		private var videoSelf:Video = null;
		private var videoOthers:Video = null;
		
		//position of video on the screen
		private var screenWidth:int;
		private var screenHeight:int;
		private var screenX:int = 0;
		private var screenY:int = 0;
		
		private var dataSet:Array = ["testliveA","testliveB","testliveC","testliveD"];
		
		//detect connection timeout
		private var connTimeoutTimer:Timer = null;
		private var reconnTimer:Timer = null; 
		
		//handling telephone events
		private var teleManager_:TelephoneManager = new TelephoneManager();
		private var callState_:int = TelephoneManager.CALL_STATE_IDLE;
		
		public function airconf()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var minBound : Number = Math.min( Screen.mainScreen.visibleBounds.width, Screen.mainScreen.visibleBounds.height );  
			var maxBound : Number = Math.max( Screen.mainScreen.visibleBounds.width, Screen.mainScreen.visibleBounds.height );  
			
			// Landscape  
			screenWidth = Math.min( stage.fullScreenWidth, maxBound );  
			screenHeight = Math.min( stage.fullScreenHeight, minBound );  
			screenX = (screenWidth*videoHeight - videoWidth * screenHeight) / (2*videoHeight);
			
			//register for back and home events
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys, false, 0, true);
			
			//telephone events
			NativeApplication.nativeApplication.addEventListener(CallStateEvent.CALL_STATE_CHANGE, onCallStateChange);
		}
		
		private function handleActivate(event:Event):void
		{
			logDebug("=>handleActivate.");
			connectServer();	
		}
		
		private function handleDeactivate(event:Event):void
		{
			logDebug("=>handleDeactivate.");
			disconnectServer();
			//Calling exit sometimes causes air app to freeze, don't call it right now.
			//NativeApplication.nativeApplication.exit();
		}
		
		//handling incoming phone calls
		private function onCallStateChange(event:CallStateEvent):void
		{
			switch ( event.callState ) {
				case TelephoneManager.CALL_STATE_RINGING:
				{
					if( callState_ != TelephoneManager.CALL_STATE_RINGING ) {
						logDebug("=>call ringing.");
						callState_ = TelephoneManager.CALL_STATE_RINGING;
						disconnectServer();
					}
					break;
				}
				case TelephoneManager.CALL_STATE_OFFHOOK:
				{
					logDebug("=>call offhook.");
					//do nothing
				}
				case TelephoneManager.CALL_STATE_IDLE:
				{
					if( callState_ != TelephoneManager.CALL_STATE_IDLE ) {
						logDebug("=>call hung up.");
						callState_ = TelephoneManager.CALL_STATE_IDLE;
						connectServer();
					}
				}				
			}
		}
		
		private function connectServer():void {
			if( netConn == null) {
				logDebug(" null!");				
			}			
			var videoPath:String = "rtmp://"+serverIp+"/myRed5App/";
			// setup connection code
			netConn = new NetConnection();
			netConn.connect(videoPath);
			netConn.addEventListener(NetStatusEvent.NET_STATUS, onConnectionNetStatus);
			netConn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			netConn.client = this;
			
			logDebug("=>connect 2 server!");
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			connTimeoutTimer = new Timer(4000);
			connTimeoutTimer.addEventListener(TimerEvent.TIMER, onReconnectTimer);
			connTimeoutTimer.start();	
		}
		
		private function disconnectServer():void {
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
				this.removeChild(videoSelf);
				videoSelf = null;
			}
			if( videoOthers ) {
				videoOthers.attachNetStream(null);
				videoOthers.clear();
				this.removeChild(videoOthers);
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
		// Define button actions.
		private function backClickHandler(evt_obj:Object):void 
		{
			if (evt_obj.detail == Alert.OK) {
				disconnectServer();
			} else if (evt_obj.detail == Alert.CANCEL) {
			}
		};
		
		
		private function handleKeys(event:KeyboardEvent):void
		{
			if( event.keyCode == Keyboard.BACK ||
				event.keyCode == Keyboard.HOME ) {
				logDebug("=>handleKeys.");
				event.preventDefault();
				
				// Display dialog box.
				Alert.show("Do you want to exit?", "Back button pressed", Alert.OK | Alert.CANCEL, null, backClickHandler, null, Alert.CANCEL);		
			}
		}
		
		public function onConnectionNetStatus(event:NetStatusEvent) : void {
			connTimeoutTimer.stop(); //cancel the timeout timer
			// did we successfully connect
			if(event.info.code == "NetConnection.Connect.Success") {
				delayedFunctionCall(1000, function(e:Event):void {publishNow();});
				logDebug("NetConnection.Connect.Success!");
			} else {
				logDebug("Unsuccessful Connection, reconnecting");
				
				reconnTimer = new Timer(3000);
				reconnTimer.addEventListener(TimerEvent.TIMER, onReconnectTimer);
				reconnTimer.start();	
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
		public function tryGetFrontCamera():Camera {
			var numCameras:uint = (Camera.isSupported) ? Camera.names.length : 0;
			for (var i:uint = 0; i < numCameras; i++) {
				var cam:Camera = Camera.getCamera(String(i));
				//logDebug(" cam position="+cam.position);
				if (cam && cam.position == CameraPosition.FRONT) {
					return cam;
				}
			} 
			return null;
		}
		public function publishNow() : void {
			
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
				camera = tryGetFrontCamera();	     
				if (camera == null) {
					logDebug("----camera null");
					Security.showSettings(SecurityPanel.CAMERA) ;
				} else{
					logDebug("----try to open microphone");
					mic = Microphone.getMicrophone();
					mic.addEventListener(StatusEvent.STATUS, onMicStatus);
					camera.addEventListener(StatusEvent.STATUS, onCameraStatus);
					camera.setMode(videoWidth, videoHeight, 30); //640*480 30 fps
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
					this.addChildAt(videoSelf, getChildIndex(videoOthers));
					videoSelf.x = screenX;
					videoSelf.y = screenY;
					videoSelf.width = (screenWidth-2*screenX)/2;
					videoSelf.height = screenHeight/2;
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
			this.addChild(videoOthers);
			//video.opaqueBackground = 0x000000;
			videoOthers.width = (screenWidth - 2*screenX);
			videoOthers.height = screenHeight;
			videoOthers.x = screenX;
			videoOthers.y = screenY;
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

			videoSelf.x = (x*(screenWidth-2*screenX))/videoWidth + screenX;
			videoSelf.y = (y*screenHeight)/videoHeight;
			videoSelf.width = (width*(screenWidth-2*screenX))/videoWidth;
			videoSelf.height = (height*screenHeight)/videoHeight;
			/*
			logDebug("videoSelf.x = " + videoSelf.x);
			logDebug("videoSelf.y = " + videoSelf.y);
			logDebug("videoSelf.width = " + videoSelf.width);			
			logDebug("videoSelf.height = " + videoSelf.height);
			*/
			this.addChild(videoOthers);
			this.addChildAt(videoSelf, getChildIndex(videoOthers));
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
		
		/*
		private function songList_changeHandler(event:IndexChangeEvent):void	
		{
			if( publishDest != null && songList.selectedIndex != 0) {
				status.text = "Song selected="+songList.selectedItem.value;
				netConn.call("song.selectSong", null, songList.selectedItem.value);	
				songList.selectedIndex = 0;
			}
		}
		
		public function songSelected(resp:Object):void	
		{
			var song:String = String(resp);
			if( song != null) {
				if( song == defaultSong ) {
					status.text = "Song stopped.";
				} else {
					status.text = "Song playing="+song;
				}
			}
		}
		// Event handler function to display the scroll location.
		private function detectVolume():void {
			var volume:Number = volumeBar.value/volumeBar.maximum;
			var micTransform:SoundTransform = mic.soundTransform;
			status.text = "volume was set to be "+micTransform.volume+" will be set to "+volume;
			micTransform.volume = volume;
			mic.soundTransform = micTransform;
		}
		
		private function volumeScroll():void {
			detectVolume();
		}
		
		protected function stopMusic_clickHandler(event:MouseEvent):void
		{
			if( publishDest != null) {
				netConn.call("song.selectSong", null, defaultSong);	
				songList.selectedIndex = 0;
			}
		}
		*/
		
		private var debug:Boolean = true;
		private var debugText:TextField = null;
		private function logDebug(str:String, showInTextField:Boolean = true):void 
		{
			//Test code
			if(debug) {
				if(showInTextField) {
					if(!debugText) {
						debugText = new TextField();
						// Autosize TextField with the text and align to CENTER.
						debugText.autoSize = TextFieldAutoSize.CENTER;
						debugText.x = 0;
						debugText.y = 0;
						var newFormat:TextFormat = new TextFormat();
						newFormat.font = "Verdana";
						newFormat.size = 30;
						newFormat.color = 0xff0000;
						debugText.setTextFormat(newFormat);
						debugText.wordWrap = true;
						debugText.width=200;
						addChild(debugText);
					}
					debugText.appendText(str+"\t");
				}
				trace(str);
			}
		}
	}
}