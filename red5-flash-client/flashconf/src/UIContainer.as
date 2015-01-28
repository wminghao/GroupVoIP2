package
{
	import com.vispar.VideoContainerDelegate;
	
	import flash.media.*;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	
	import spark.components.TextArea;
	
	public class UIContainer extends UIComponent implements VideoContainerDelegate
	{
		private var debugText_:TextArea;
		private var videoSet_:ArrayCollection;
		private var videoWidth_:int = 640;
		private var videoHeight_:int = 480;
		private var edgeX_:int; //leave the top area for display label and others
		private var edgeY_:int; //leave the top area for display label and others

		public function UIContainer()
		{
			super();
		}
		
		public function setInfo(edgeX:int, edgeY:int, 
								debugText:TextArea,
								videoSet:ArrayCollection):void {
			this.edgeX_ = edgeX;
			this.edgeY_ = edgeY;
			this.debugText_ = debugText;	
			this.videoSet_ = videoSet;
			//logDebug("----screenWidth="+this.width+" screenHeight="+this.height+" screenX="+(this.x + edgeX_)+" screenY="+(this.y + edgeY_));
		}
		
		//debug functions
		private var debug:Boolean = true;
		public function logDebug(str:String, showInTextField:Boolean = true):void 
		{
			//Test code
			if(debug && debugText_ ) {
				debugText_.text += str;
				//trace(str);
			}
		}
		public function showAlert(str:String):void
		{
			Alert.show(str);
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
			return this.x + edgeX_; //leave no space between
		}
		public function getScreenY():int
		{
			return this.y + edgeY_; //leave the top area for display label and others
		}
		
		public function tryGetFrontCamera():Camera {
			var numCameras:uint = (Camera.isSupported) ? Camera.names.length : 0;
			for (var i:uint = 0; i < numCameras; i++) {
				var cam:Camera = Camera.getCamera(String(i));
				return cam;
			} 
			return null;
		}
		
		public function onVideoSelected(videoName:String):void {
			logDebug("Now playing="+videoName+" ");
		}
		public function onVideoListPopulated(videoNamesArray:Array):void {
			var arrLen:int = videoNamesArray.length;
			for (var i:int = 0; i<arrLen; i++) {
				var vidName:String = videoNamesArray[i];
				videoSet_.addItem({'value':vidName, 'code':vidName});
				//logDebug("vidName="+vidName+" ");
			}
		}
	}
}