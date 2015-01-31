package com.vispar
{
	import flash.media.Camera;
	public interface VideoContainerDelegate
	{
		function logDebug(str:String):void;
		function showAlert(str:String):void;
		
		function tryGetFrontCamera():Camera;
		
		function getVideoWidth():int;
		function getVideoHeight():int;
		function getScreenWidth():int;
		function getScreenHeight():int;		
		function getScreenX():int;
		function getScreenY():int;
		
		function onVideoSelected(videoName:String):void;
		function onVideoListPopulated(videoNamesArray:Array):void;
	}
}