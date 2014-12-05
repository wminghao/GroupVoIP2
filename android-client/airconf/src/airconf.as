package
{
	import com.vispar.*;
	import com.vispar.ui.AlertBox;
	import com.wadedwalker.nativeExtension.telephone.CallStateEvent;
	import com.wadedwalker.nativeExtension.telephone.DataActivityEvent;
	import com.wadedwalker.nativeExtension.telephone.DataConnectionStateEvent;
	import com.wadedwalker.nativeExtension.telephone.TelephoneManager;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.text.*;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
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
		private var bIsLive_:Boolean = false;
	
		//whether to ignore back button or not
		private var ignoreBack:Boolean = false;
		//wheter deactivate indicates exit. (Home button)
		private var deactivateExit:Boolean = true;
		
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
			
			logDebug("=>onInvoke="+event.arguments[0]);
			logDebug("reason: " + event.reason);  
			logDebug("arguments.length: " + event.arguments.length);  
			if( event.arguments[0]!=null ) {
				var arg:String = event.arguments[0];
				arg = arg.substr(arg.indexOf("//") + 2);
				logDebug("=>arg="+arg);

				var endIndex:int = arg.indexOf("/");
				var typeStr:String = arg.substring(0, endIndex);
				bIsLive_ = ( typeStr == "live");
				logDebug("=>typeStr="+typeStr);				
			}
			if( bIsLive_ ) {
				vidInstance_ = new VideoConn(this, this);
			} else {
				vidInstance_ = new VideoPlayer(this, this);				
			}
		}		
		
		private function handleActivate(event:Event):void
		{
			logDebug("=>handleActivate.");
			vidInstance_.connectServer();	
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
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
		
		
		//debug functions
		private var debug:Boolean = true;
		private var debugText:TextField = null;
		public function logDebug(str:String, showInTextField:Boolean = true):void 
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
	}
}