package com.vispar
{
	import flash.display.Sprite;
	public class VideoContainer
	{
		//parent container
		protected var container_:Sprite = null;
		
		//delegate
		protected var delegate_:VideoContainerDelegate = null;
		
		protected function logDebug(str:String):void {
			delegate_.logDebug(str, true);
		}
		
		public function VideoContainer(container:Sprite, delegate:VideoContainerDelegate)
		{ 
			this.container_ = container;
			this.delegate_ = delegate;
		}
		
		public function connectServer():void {
		}
		
		public function disconnectServer():void {
		}
	}
}