package ui.alert
{
	import fl.controls.Button;
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	//example from http://sibirjak.com/osflash/blog/tutorial-creating-an-alert-box-with-the-as3commons-popupmanager/
	public class AlertBox extends Sprite {
		public static const ALERT_YES : String = "yes";
		public static const ALERT_NO : String = "no";
		private var _clickCallback : Function;
		private var _logDebug : Function;
		
		public function AlertBox(headline : String, 
								 text : String, 
								 buttons : Array, 
								 rect:Rectangle,
								 clickCallback : Function,
								 logDebug:Function) {
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			_clickCallback = clickCallback;
			_logDebug = logDebug;
			
			var padding : uint = 10;
			
			// shadow and background
			with (graphics) {
				beginFill(0x999999, .15);
				drawRect(rect.x+8, rect.y+8, rect.width, rect.height);
				lineStyle(1, 0xCCCCCC);
				beginFill(0xFFFFFF);
				drawRect(rect.x, rect.y, rect.width, rect.height);
			}
			
			// headline
			var tf1 : TextField = new TextField();
			tf1.autoSize = TextFieldAutoSize.LEFT;
			tf1.defaultTextFormat = new TextFormat("_sans", 32, 0x444444, false);
			tf1.textColor = 0xff0000;
			tf1.text = headline;  
			tf1.x = rect.x + 20;
			tf1.y = rect.y + 20;
			
			this.addChild(tf1);
			
			
			// text
			var tf2 : TextField = new TextField();
			tf2.width = rect.width - 2*padding;
			tf2.autoSize = TextFieldAutoSize.LEFT;
			tf2.wordWrap = true;
			tf2.defaultTextFormat = new TextFormat("_sans", 24, 0x444444);
			tf2.text = text;
			tf2.x = rect.x + 20;
			tf2.y = rect.y + 20 + 100;
			
			this.addChild(tf2);
			
			// buttons
			if (buttons) {
				if (buttons[0]) {
					var b0:Button = createButton(buttons[0], ALERT_YES);
					b0.x = rect.x + 20;
					b0.y = rect.y + rect.height-60;
					this.addChild(b0);
				}
				if (buttons[1]) {
					var b1:Button = createButton(buttons[1], ALERT_NO);
					b1.x = rect.x + 20 + rect.width/2;
					b1.y = rect.y + rect.height-60;
					this.addChild(b1);
				}
			}
		}
		
		private function createButton(label : String, eventType : String) : Button {
			var button : Button = new Button();
			button.setSize(120, 44);
			button.label = label;
			button.enabled = true;
			var enabledTextFormat:TextFormat = new TextFormat();
			enabledTextFormat.bold = true;
			enabledTextFormat.size = 18;
			enabledTextFormat.color = 0x0000FF;
			//button.setStyle("embedFonts", true);
			button.setStyle("textFormat", enabledTextFormat);
			button.emphasized = true;
			button.textField.defaultTextFormat = enabledTextFormat;
			_logDebug("------here--------");
			button.addEventListener(TouchEvent.TOUCH_BEGIN, function(event : Event) : void {
				buttonClickHandler(eventType);
				_logDebug("-----on touched---------");
			});
			button.addEventListener(MouseEvent.CLICK, function(event : Event) : void {
				buttonClickHandler(eventType);
				_logDebug("-----on clicked---------");
			});
			_logDebug("------there--------");
			return button;
		}
		
		private function buttonClickHandler(eventType : String) : void {
			_clickCallback(this, eventType);
		}
	}
}