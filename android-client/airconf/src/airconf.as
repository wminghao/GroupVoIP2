package
{
	import com.wadedwalker.nativeExtension.telephone.CallStateEvent;
	import com.wadedwalker.nativeExtension.telephone.DataActivityEvent;
	import com.wadedwalker.nativeExtension.telephone.DataConnectionStateEvent;
	import com.wadedwalker.nativeExtension.telephone.TelephoneManager;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import mx.controls.Alert;
	
	import com.vispar.*;
	
	public class airconf extends Sprite implements VideoConnDelegate
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
		
		//vidconnection class
		private var vidConn_:VideoConn = null;
		
		public function airconf()
		{
			super();
			
			vidConn_ = new VideoConn(this, this);
			
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
			vidConn_.connectServer();	
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		
		private function handleDeactivate(event:Event):void
		{
			logDebug("=>handleDeactivate.");
			vidConn_.disconnectServer();
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
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
						vidConn_.disconnectServer();
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
						vidConn_.connectServer();
					}
				}				
			}
		}
		
		private function handleKeys(event:KeyboardEvent):void
		{
			if( event.keyCode == Keyboard.BACK ||
				event.keyCode == Keyboard.HOME ) {
				logDebug("=>handleKeys.");
				event.preventDefault();
				
				function backClickHandler(evt_obj:Object):void 
				{
					if (evt_obj.detail == Alert.OK) {
						vidConn_.disconnectServer();
					} else if (evt_obj.detail == Alert.CANCEL) {
					}
				};
				
				try {
					// Display dialog box.
					Alert.show("Do you want to exit?");
					//Alert.show("Do you want to exit?", "Back button pressed", Alert.OK | Alert.CANCEL, null, backClickHandler);
				}catch(e:Error) {
					logDebug("---handleKeys Exception="+e.message + " id="+e.errorID + " name="+e.name);
					logDebug("---stack trace =" + e.getStackTrace());
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