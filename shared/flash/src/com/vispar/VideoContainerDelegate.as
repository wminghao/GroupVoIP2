package com.vispar
{
	import flash.media.Camera;
	public interface VideoContainerDelegate
	{
		function logDebug(str:String, showInTextField:Boolean = true):void;
		
		function tryGetFrontCamera():Camera;
		
		function getVideoWidth():int;
		function getVideoHeight():int;
		function getScreenWidth():int;
		function getScreenHeight():int;		
		function getScreenX():int;
		function getScreenY():int;
	}
}