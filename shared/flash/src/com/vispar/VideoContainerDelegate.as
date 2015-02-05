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
		
		function onVideoSelected(videoName:String):void;
		function onVideoListPopulated(videoNamesArray:Array):void;
	}
}