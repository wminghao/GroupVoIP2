package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.media.*;
	import flash.net.*;
	import flash.events.*;
	import flash.system.*;
	import flash.utils.*;
	import flash.text.*;
	
	public class airconf extends Sprite
	{
		private var streamPub:NetStream; //must declare outside, otherwise, gc will recycle it.
		private var streamViewA:NetStream; //must declare outside
		private var streamViewB:NetStream; //must declare outside
		
		private var connectionPub:NetConnection;			
		private var connectionSub:NetConnection;
		private var mic:Microphone;
		
		private var serverIp:String = "54.186.122.59";//"192.168.2.109";//"54.186.122.59";//"192.168.0.61";
		private var mixedStreamPrefix:String = "__mixed__";
		private var karaokeStream:String = "__mixed__karaoke";
		private var defaultSong:String = "Default"; //default song means mtv stopped
		
		private var publishDest:String = null;
		private var publishedStreamArray:Vector.<String> = new Vector.<String>();
		
		private var videoWidth:int = 320;
		private var videoHeight:int = 240;
		private var positionArray:Array = [ [0, 0], [0, videoHeight]];
		
		private var dataSet:Array = ["testliveA","testliveB"];
		
		public function airconf()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var videoPath:String = "rtmp://"+serverIp+"/myRed5App/";
			// setup connection code
			connectionPub = new NetConnection();
			connectionPub.connect(videoPath);
			connectionPub.addEventListener(NetStatusEvent.NET_STATUS, onConnectionANetStatus);
			connectionPub.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			connectionPub.client = this;	
		}
		
		public function onConnectionANetStatus(event:NetStatusEvent) : void {
			// did we successfully connect
			if(event.info.code == "NetConnection.Connect.Success") {
				delayedFunctionCall(1000, function(e:Event):void {publishNow();});
				//Alert.show("NetConnection.Connect.Success!", "Information");
			} else {
				logDebug("Unsuccessful Connection");
			}
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
					//Alert.show("Camera Access Has Been Denied!", "Information");
					break;
			}
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
			
			if( publishDest == null ) {
				//Alert.show("Cannot only listen to karaoke, since the room is already full!", "Information");
				karaokeStream += "_delayed"; //listen to the delayed stream
				subscribeStreams(); //only showing streams
				return;
			}
			var camera:Camera = Camera.getCamera();	     
			mic = Microphone.getMicrophone();
			camera.addEventListener(StatusEvent.STATUS, onCameraStatus) ;
			mic.addEventListener(StatusEvent.STATUS, onMicStatus);
			if (camera == null) {
				Security.showSettings(SecurityPanel.CAMERA) ;
			} else{
				camera.setMode(videoWidth*2, videoHeight*2, 30); //640*480 30 fps
				camera.setQuality(16384,0); //0% quality, 16kBytes/sec bw limitation
				
				streamPub = new NetStream(connectionPub);
				var h264settings:H264VideoStreamSettings = new H264VideoStreamSettings(); 
				h264settings.setProfileLevel(H264Profile.BASELINE, H264Level.LEVEL_1_2);
				streamPub.videoStreamSettings = h264settings; 
				streamPub.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				streamPub.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
				streamPub.attachCamera(camera);
				streamPub.publish(publishDest, "live");
				
				var video:Video = new Video();
				video.attachCamera(camera) ;
				this.addChild(video);
				video.width = videoWidth;
				video.height = videoHeight;
				video.x = video.y = 0;
				video.visible = true;
				
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
		}
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetStream.Play.StreamNotFound":
					logDebug("Unable to locate video: " + publishDest);
					break;
				case "NetStream.Publish.Start":
					//Alert.show("Publisher starts here");
					subscribeStreams();
					break;
				case "NetStream.Play.Start":
				case "NetStream.Play.Reset":
				case "Netstream.Play.PublishNotify":
				case "Netstream.Play.UnpublishNotify":
				case "NetStream.Video.DimensionChange":
					break;
				default:
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
		public function subscribeStreams():void {
			var videoPath:String = "rtmp://"+serverIp+"/myRed5App/";
			// setup connection code
			connectionSub = new NetConnection();
			connectionSub.connect(videoPath);  //subscribe to live video
			//connection.connect("rtmp://localhost/vod/"); existing flv file/mp4 files
			connectionSub.addEventListener(NetStatusEvent.NET_STATUS, onConnectionBNetStatus);
			connectionSub.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			connectionSub.client = this;
		}
		public function onConnectionBNetStatus(event:NetStatusEvent) : void {
			// did we successfully connect
			if(event.info.code == "NetConnection.Connect.Success") {
				//Alert.show("onConnectionBNetStatus: " + event, "Information");
				connectStreams();
			} else {
				logDebug("Unsuccessful Connection");
				disconnectStreams();
			}
		}
		
		private function disconnectStreams():void {
			//TODO
		}	
		
		private function connectStreams():void {
			/* don't subscribe to anything else.
			var posIndex:int = 1;
			if( publishDest == null) {
				streamViewA = new NetStream(connectionSub);
				var itemA:String = dataSet.getItemAt(posIndex-1);
				connectStream(streamViewA, itemA, positionArray[posIndex-1][0], positionArray[posIndex-1][1], videoWidth, videoHeight);
				posIndex++;
				streamViewB = new NetStream(connectionSub);
				var itemB:String = dataSet.getItemAt(posIndex-1);
				connectStream(streamViewB, itemB, positionArray[posIndex-1][0], positionArray[posIndex-1][1], videoWidth, videoHeight);
				posIndex++;
			} else {
				for each(var item:String in dataSet){
					if( item != publishDest ) {
						var streamView:NetStream = new NetStream(connectionSub);
						connectStream(streamView, item, positionArray[posIndex][0], positionArray[posIndex][1], videoWidth, videoHeight);
						posIndex++;
					}
				}
			}
			*/
			// next is karaoke
			var streamKara:NetStream = new NetStream(connectionSub);
			connectStream(streamKara, karaokeStream, videoWidth, 0, videoWidth*2, videoHeight*2 );
			
			/*
			for (var i:int = 0; i < container.numChildren; i++)
			{
			var obj:Video = container.getChildAt(i) as Video;
			Alert.show(obj.x + " "+ obj.y + " "+obj.width + " "+obj.height + " "+ publishDest);
			}
			*/
		}
		
		private function connectStream(stream:NetStream, url:String, x:int, y:int, width:int, height:int):void {
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			stream.play(url);
			
			var video:Video = new Video();
			video.attachNetStream(stream);
			this.addChild(video);
			//video.opaqueBackground = 0x000000;
			video.width = width;
			video.height = height;
			video.x = x;
			video.y = y;
			video.visible = true;
		}
		//server call to client
		private function newStream(publishedStream:String):void {
			if( publishedStreamArray.indexOf(publishedStream) == -1 && 
				publishedStream.indexOf(mixedStreamPrefix) < 0 && 
				publishedStream != publishDest ){ 
				//Alert.show("A new connection "+publishedStream+" joined", "Information");
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
			//Alert.show("initStreams = "+streamListStr, "Information"); 
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
		private function onLoopBack(evt:MouseEvent):void {
			detectLoopback();
		}
		private function detectLoopback():void {
			if(CheckBox(loopback).selected) {
			mic.setLoopBack(true);
			mic.setUseEchoSuppression(true);
			} else {
			mic.setLoopBack(false);
			mic.setUseEchoSuppression(false);
			}
		}
		private function songList_changeHandler(event:IndexChangeEvent):void	
		{
			if( publishDest != null && songList.selectedIndex != 0) {
				status.text = "Song selected="+songList.selectedItem.value;
				connectionPub.call("song.selectSong", null, songList.selectedItem.value);	
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
				connectionPub.call("song.selectSong", null, defaultSong);	
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