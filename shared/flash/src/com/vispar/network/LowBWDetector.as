package com.vispar.network
{
	public class LowBWDetector
	{
		private var lowBWNotificationArray_:Array = [];
		private var stopVideoCallback_:Function;
		private var logDebug_:Function;
		
		//if within 30 seconds, there are more than 3 low bw notifications, we treat it as fatal.
		private const numOfNotificationThreshold_:int = 3;
		private const timeIntervalThreshold_:int = 30; //30 seconds
		public function LowBWDetector(stopVideoCallback:Function, logDebug:Function)
		{
			this.stopVideoCallback_ = stopVideoCallback;
			this.logDebug_ = logDebug;
		}
		
		public function onLowBWNotification():void
		{
			var currentTs:Number = getCurrentEpochTime();
			lowBWNotificationArray_.push( currentTs );
			this.logDebug_("---onLowBWNotification ts="+getCurrentEpochTime());
			if( lowBWNotificationArray_.length == numOfNotificationThreshold_ ) {
				var firstBWNotificationTs:Number = lowBWNotificationArray_.shift();
				this.logDebug_("---diff="+(currentTs - firstBWNotificationTs) );
				if( currentTs < (firstBWNotificationTs + timeIntervalThreshold_) ) {
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