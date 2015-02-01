package
{
	import com.vispar.*;
	import com.wadedwalker.nativeExtension.telephone.CallStateEvent;
	import com.wadedwalker.nativeExtension.telephone.DataActivityEvent;
	import com.wadedwalker.nativeExtension.telephone.DataConnectionStateEvent;
	import com.wadedwalker.nativeExtension.telephone.TelephoneManager;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.media.*;
	import flash.text.*;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import ui.alert.*;
	
	public class airconf extends Sprite implements VideoContainerDelegate
	{		
		private var videoWidth:int = 640;
		private var videoHeight:int = 480;
		
		//position of video on the screen
		private var screenWidth:int;
		private var screenHeight:int;
		private var screenX:int = 0;
		private var screenY:int = 0;
		
		//handling telephone events
		private var teleManager_:TelephoneManager = new TelephoneManager();
		private var callState_:int = TelephoneManager.CALL_STATE_IDLE;
		
		//vidContainer class
		private var vidInstance_:VideoContainer = null;
	
		//whether to ignore back button or not
		private var ignoreBack:Boolean = false;
		//wheter deactivate indicates exit. (Home button)
		private var deactivateExit:Boolean = true;
		
		//alert box
		private static var alertBoxWidth:int = 400;
		private static var alertBoxHeight:int = 400;
		
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
			
			//logDebug("----screenWidth="+screenWidth+" screenHeight="+screenHeight+" screenX="+screenX);
			
			//invoke events for parameter passing.
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
			
			//register for back and home events
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys, false, 0, true);
			
			//telephone events
			NativeApplication.nativeApplication.addEventListener(CallStateEvent.CALL_STATE_CHANGE, onCallStateChange);
		}
		
		private function onInvoke(event:InvokeEvent):void
		{	
			//example parameters
			//live: "vispar.player://live/rooms/howard/now";
			//vod: "vispar.player://vod/rooms/howard/1234567890";
			var room:String = null;
			var bIsArchive:Boolean = false;
			//logDebug("reason: " + event.reason);  
			//logDebug("arguments.length: " + event.arguments.length);  
			if( event.arguments.length > 0 && event.arguments[0]!=null ) {
				//logDebug("=>onInvoke="+event.arguments[0]);
				var arg:String = event.arguments[0];
				arg = arg.substr(arg.indexOf("//") + 2);
				//logDebug("=>arg="+arg);

				var endIndex:int = arg.indexOf("/");
				var typeStr:String = arg.substring(0, endIndex);
				bIsArchive = ( typeStr == "vod");
				//logDebug("=>typeStr="+typeStr);	
				
				//skip the next parameter
				arg = arg.substr(endIndex + 1);
				endIndex = arg.indexOf("/");
				arg = arg.substr(endIndex + 1);
				endIndex = arg.indexOf("/");
				room = arg.substring(0, endIndex);
			}
			if( bIsArchive ) {
				vidInstance_ = new VideoPlayer(this, this, room);
			} else {				
				vidInstance_ = new VideoConf(this, this, room);
			}
		}		
		
		private function handleActivate(event:Event):void
		{
			logDebug("=>handleActivate.");
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			var detectNetworkFunc:Function = function (eventType : String):void {
				if( eventType == AlertBox.ALERT_YES ) {
					vidInstance_.connectServer();						
				} else { //AlertBox.ALERT_NO
					backClickHandler(); //treat the same way as backbutton					
				}
			}
			showAlertWithCallback( "Warning",
								   "You must have at least 1Mbps network upload and download speed to join a realtime session!", 
								   ["Continue", "Cancel"], 
								   detectNetworkFunc);
		}
		
		
		
		private function handleDeactivate(event:Event):void
		{
			logDebug("=>handleDeactivate.");
			vidInstance_.disconnectServer();
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
			
			if ( deactivateExit ) {
				//Calling exit sometimes causes air app to freeze, don't call it right now.
				NativeApplication.nativeApplication.exit();
			}
		}
		
		private function backClickHandler():void 
		{
			vidInstance_.disconnectServer();
			//Calling exit sometimes causes air app to freeze, don't call it right now.
			NativeApplication.nativeApplication.exit();
		};
		
		
		//handling incoming phone calls
		private function onCallStateChange(event:CallStateEvent):void
		{
			switch ( event.callState ) {
				case TelephoneManager.CALL_STATE_RINGING:
				{
					if( callState_ != TelephoneManager.CALL_STATE_RINGING ) {
						logDebug("=>call ringing.");
						callState_ = TelephoneManager.CALL_STATE_RINGING;
						vidInstance_.disconnectServer();
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
						vidInstance_.connectServer();
					}
				}				
			}
		}
		
		private function handleKeys(event:KeyboardEvent):void
		{
			if( event.keyCode == Keyboard.BACK ||
				event.keyCode == Keyboard.HOME ) {
				logDebug("=>handleKeys.");
				
				if( !ignoreBack ) {
					backClickHandler();
				} else {
					//ignore the event
					event.preventDefault();
				}
			}
		}
		
		public function showAlert(str:String):void 
		{
			showAlertWithCallback("Alert", str, ["OK"], null);
		}
		
		public function showAlertWithCallback(title:String, str:String, button:Array, myFunc:Function):void
		{
			try {
				var rect:Rectangle = new Rectangle( stage.fullScreenWidth/2-alertBoxWidth/2, stage.fullScreenHeight/2-alertBoxHeight/2, 
													alertBoxWidth, alertBoxHeight );
				var alert:AlertBox = new AlertBox(  title, 
													str, 
													button,
													rect,
													myFunc,
													logDebug);
				this.addChild(alert);
			} catch(err:Error) {
				logDebug(err.toString());
			}
		}
		
		//debug functions
		private var debug:Boolean = true;
		private var debugText:TextField = null;
		public function logDebug(str:String):void 
		{
			//Test code
			if(debug) {
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
					debugText.width=140;
					addChild(debugText);
				}
				debugText.appendText(str+"\t");
				trace(str);
			}
		}
		
		//delegate functions
		public function getVideoWidth():int
		{
			return videoWidth;
		}
		public function getVideoHeight():int
		{
			return videoHeight;
		}
		public function getScreenWidth():int
		{
			return screenWidth;
		}
		public function getScreenHeight():int
		{
			return screenHeight;
		}
		public function getScreenX():int
		{
			return screenX;
		}
		public function getScreenY():int
		{
			return screenY;
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
		
		public function onVideoSelected(videoName:String):void {
			//logDebug("Now playing="+videoName);
		}
		public function onVideoListPopulated(videoNamesArray:Array):void {
		}
	}
}