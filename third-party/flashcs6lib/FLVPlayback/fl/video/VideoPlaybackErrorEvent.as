/*************************************************************************
*
* ADOBE CONFIDENTIAL
* ___________________
*
*  Copyright 2006 Adobe Systems Incorporated
*  All Rights Reserved.
*
* NOTICE:  All information contained herein is, and remains
* the property of Adobe Systems Incorporated and its suppliers,
* if any.  The intellectual and technical concepts contained
* herein are proprietary to Adobe Systems Incorporated and its
* suppliers and may be covered by U.S. and Foreign Patents,
* patents in process, and are protected by trade secret or copyright law.
* Dissemination of this information or reproduction of this material
* is strictly forbidden unless prior written permission is obtained
* from Adobe Systems Incorporated.
**************************************************************************/
package fl.video
{
	import flash.events.Event;
	/**
     * @private intended only for AMP workaround.
     *
	 */
	public class VideoPlaybackErrorEvent extends Event
	{
		public var reason:String = REASON_UNKNOWN;
		
		public static const REASON_UNKNOWN:String = "Unknown error";
		public static const REASON_INVALID_SEEK:String = "Invalid seek";
		public static const REASON_ERROR_SETTING_STATE:String = "Error setting video state";
		public static const PLAYBACK_ERROR:String = "videoPlaybackError";
		
		public function VideoPlaybackErrorEvent(reason:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			this.reason = reason;
			super(PLAYBACK_ERROR, bubbles, cancelable);
		}

		public override function clone():Event
		{
			return new VideoPlaybackErrorEvent(reason);
		}

	}
}