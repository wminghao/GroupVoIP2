package com.vispar
{
	import flash.media.Camera;
	public interface VideoContainerDelegate
	{
		function logDebug(str:String):void;
		function showAlert(str:String):void;
		function onFatalNetworkTooSlowError():void;
		
		function tryGetFrontCamera():Camera;
		
		function getVideoWidth():int;
		function getVideoHeight():int;
		function getScreenWidth():int;
		function getScreenHeight():int;		
		function getScreenX():int;
		function getScreenY():int;
		
		function onVideoStarted(isViewOnly:Boolean):void; //return whether it's viewer mode or talker mode
		
		function onExternalVideoPlaying(videoName:String):void;
		function onExternalVideoStarted():void;
		function onExternalVideoStopped():void;
		function onExternalVideoListPopulated(videoNamesArray:Array):void;
		
		//request to talk to main UI
		function onRequest2TalkPendingApproval(isPending:Boolean):void;
		function onRequest2TalkNeedsApproval(user:String):void;
	}
}