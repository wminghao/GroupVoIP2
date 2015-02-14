package com.vispar.network
{
	public class LowPublishBWDetector
	{
		private var bwArray_:Array = [];
		private var stopVideoCallback_:Function;
		private var logDebug_:Function;
		private const maxArraySize_:int = 10;
		private const audioOnlyBWThreshold_:int = 500; //less than 500kbps
		private const shutdownAllBWThreshold_:int = 100; //less than 100kbps
		private var hasAudioOnlyCallbackSent_:Boolean = false; //only sent once
		
		public function LowPublishBWDetector(stopVideoCallback:Function, logDebug:Function)
		{
			this.stopVideoCallback_ = stopVideoCallback;
			this.logDebug_ = logDebug;
		}
		public function onPublishBWDetected(bwInKBps:Number):void
		{
			bwArray_.push( bwInKBps );
			//this.logDebug_("---bwInKBps="+bwInKBps);
			if( bwArray_.length == maxArraySize_ ) {
				var avgBW:Number = 0;
				var totalBW:Number = 0;
				for(var i:int = 0; i< maxArraySize_; i++) {
					totalBW += bwArray_[i] as Number;
				}
				avgBW = totalBW/maxArraySize_;
				//this.logDebug_("---avg="+avgBW+"kbps" );
				bwArray_.shift();
				//it can be shut down or it can be audio only
				if( avgBW < shutdownAllBWThreshold_ ) {
					this.stopVideoCallback_(false, "upload");
				} else if( avgBW < audioOnlyBWThreshold_ ) {
					if( !hasAudioOnlyCallbackSent_ ) {
						this.stopVideoCallback_(true, "upload");
						hasAudioOnlyCallbackSent_ = true;
					}
				}
			}
		}
	}
}