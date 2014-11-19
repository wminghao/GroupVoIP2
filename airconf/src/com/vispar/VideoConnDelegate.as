package com.vispar
{
	public interface VideoConnDelegate
	{
		function logDebug(str:String, showInTextField:Boolean = true):void;
		
		function getVideoWidth():int;
		function getVideoHeight():int;
		function getScreenWidth():int;
		function getScreenHeight():int;		
		function getScreenX():int;
		function getScreenY():int;
	}
}