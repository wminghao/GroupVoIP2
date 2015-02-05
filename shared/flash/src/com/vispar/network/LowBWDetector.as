package com.vispar.network
{
	public class LowBWDetector
	{
		private var lowBWNotificationArray_:Array = [];
		private var stopVideoCallback_:Function;
		
		//if within 20 seconds, there are more than 3 low bw notifications, we treat it as fatal.
		private const numOfNotificationThreshold_:int = 3;
		private const timeIntervalThreshold_:int = 20; //20 seconds
		public function LowBWDetector(stopVideoCallback:Function)
		{
			this.stopVideoCallback_ = stopVideoCallback;
		}
		
		public function onLowBWNotification():void
		{
			if( lowBWNotificationArray_.length < numOfNotificationThreshold_ ) {
				lowBWNotificationArray_.push( getCurrentEpochTime() );
			} else {
				var firstBWNotificationTs:Number =lowBWNotificationArray_.shift();
				var currentTs:Number = getCurrentEpochTime();
				if( currentTs > (firstBWNotificationTs + timeIntervalThreshold_) ) {
					lowBWNotificationArray_.push( getCurrentEpochTime() );
				} else {
					this.stopVideoCallback_();
				}
			}
		}
		
		private function getCurrentEpochTime():Number {
			var now:Date = new Date();
			var epoch:Number = Date.UTC(now.fullYear, now.month, now.date, now.hours, now.minutes, now.seconds, now.milliseconds);
			return epoch/1000;
		}
	}
}