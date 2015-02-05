package com.vispar.network
{
	public class NetworkDisconnectDetector
	{
		private var stopVideoCallback_:Function;
		
		//if within 3 disconnect notifications, we treat it as fatal.
		private const numOfDisconnectThreshold_:int = 3;
		
		private var numOfContDisconnect_:int = 0;
		
		public function NetworkDisconnectDetector(stopVideoCallback:Function)
		{
			this.stopVideoCallback_ = stopVideoCallback;
			this.numOfContDisconnect_ = 0;
		}
		
		public function onDisconnectNotification():Boolean
		{
			this.numOfContDisconnect_++;
			if( this.numOfContDisconnect_ >= numOfDisconnectThreshold_ ) {
				this.stopVideoCallback_();
				return false;
			}
			return true;
		}
		public function onConnectNotification():void
		{
			this.numOfContDisconnect_ = 0;
		}
	}
}