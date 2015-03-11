package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import com.vispar.extension.Chatroom;
	
	public class chatroomtest extends Sprite
	{
		public function chatroomtest()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Chatroom.showChatroom("abc");
		}
	}
}