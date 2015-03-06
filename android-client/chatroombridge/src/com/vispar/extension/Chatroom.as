package com.vispar.extension
{
	import flash.external.ExtensionContext;
	import flash.events.EventDispatcher;
	
	public class Chatroom extends EventDispatcher
	{
		/** Extension Context */
		private static var extContext:ExtensionContext=null;
		
		public function Chatroom()
		{	
		}
		
		/**
		 * Display a simple Android Dialog box.
		 * @param	msg	the message you wish to display.
		 */
		public static function showChatroom(msg:String):void
		{
			initContext();
			extContext.call("ffiShowChatroom",msg);
		}
		
		//
		// Implementation
		//
		
		/** Init Context */
		private static function initContext():void
		{
			if(!extContext)
			{
				extContext=ExtensionContext.createExtensionContext("com.vispar.extension.ChatroomDialog","");
				extContext.call("ffiInit");
			}
		}
	}
}