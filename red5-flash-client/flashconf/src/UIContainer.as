package
{
	import com.vispar.VideoContainerDelegate;
	
	import mx.core.UIComponent;
	
	import spark.components.TextArea;
	import flash.media.*;
	import mx.controls.Alert;
	
	public class UIContainer extends UIComponent implements VideoContainerDelegate
	{
		private var debugText_:TextArea;
		private var videoWidth_:int = 640;
		private var videoHeight_:int = 640;

		public function UIContainer()
		{
			super();
		}
		
		public function setDebugArea(debugText:TextArea):void {
			this.debugText_ = debugText;			
		}
		
		//debug functions
		private var debug:Boolean = true;
		public function logDebug(str:String, showInTextField:Boolean = true):void 
		{
			//Test code
			if(debug) {
				debugText_.text += str;
				//trace(str);
			}
		}
		
		//delegate functions
		public function getVideoWidth():int
		{
			return videoWidth_;
		}
		public function getVideoHeight():int
		{
			return videoHeight_;
		}
		public function getScreenWidth():int
		{
			return this.width;
		}
		public function getScreenHeight():int
		{
			return this.height;
		}
		public function getScreenX():int
		{
			return this.x;
		}
		public function getScreenY():int
		{
			return this.y;
		}
		
		public function tryGetFrontCamera():Camera {
			var numCameras:uint = (Camera.isSupported) ? Camera.names.length : 0;
			for (var i:uint = 0; i < numCameras; i++) {
				var cam:Camera = Camera.getCamera(String(i));
				return cam;
			} 
			return null;
		}
	}
}