package com.vispar
{
	import flash.display.Sprite;
	public class VideoContainer
	{
		//parent container
		protected var container_:Sprite = null;
		
		//delegate
		protected var delegate_:VideoContainerDelegate = null;
		
		//room name
		protected var room:String = null;
		
		//ip address
		protected var serverIp:String = "54.148.16.2";//"54.201.108.66";//"192.168.2.109";//"192.168.0.61";
		protected function logDebug(str:String):void {
			delegate_.logDebug(str);
		}
		protected function showAlert(str:String):void {
			delegate_.showAlert(str);
		}
		
		public function VideoContainer(container:Sprite, delegate:VideoContainerDelegate,  room:String)
		{ 
			this.container_ = container;
			this.delegate_ = delegate;
			this.room = room;
		}
		
		public function connectServer():void {
		}
		
		public function disconnectServer():void {
		}
		
		public function selectVideo(videoName:String):void {
		}
		public function stopVideo():void {
		}
		
		public function isViewOnly():Boolean {
			return false;
		}
		public function switchToViewOnly(forceViewOnly:Boolean):void {			
		}
	}
}