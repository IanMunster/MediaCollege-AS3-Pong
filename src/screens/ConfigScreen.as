package screens 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import utils.Controller;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author erwin henraat & Ian Munster
	 */
	public class ConfigScreen extends Screen 
	{
		private var title:TextField;
		private var player1:TextField;
		private var player2:TextField;
		private var shooter:TextField;
		private var clicked:Boolean = false;
		private var start:TextField;
		public static var vs_P2:Boolean;
		public static var shooter_Game:Boolean;
		public static const CONFIG_SCREEN:String = "Config Game";
		public static const START_GAME:String = "start game";		
			/*Probeerseltje*/
		public function vsAI(e:MouseEvent):void {
			vs_P2 = false;
			player1.text = "> Play against Ai <";
			player2.text = "Play against Player2";
			trace("versus ai is geklikt"); //test trace
			}
		public function vsPL(e:MouseEvent):void {
			vs_P2 = true;
			player1.text = "Play against Ai";
			player2.text = "> Play against Player2 <";
			trace("versus player2 is geklikt"); //test trace
			}
			public function setSHTR(e:MouseEvent):void {
				
				if (!clicked) {
					shooter_Game = true;
					shooter.text = ">Shooter Mode<";
					trace("shooter mode enabled"); // test trace
					clicked = true;
				} else if (clicked) {
					shooter_Game = false;
					shooter.text = "Shooter Mode";
					trace("shooter mode disabled"); // test trace
					clicked = false;
				}
				
			}
			/*Probeerseltje*/
		/*Probeerseltje*/
		public function ConfigScreen() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
						
			title = new TextField();
			title.embedFonts = true;
			title.text = "vs. Ai or vs. Player2";
			title.autoSize = TextFieldAutoSize.CENTER;			
			title.setTextFormat(textFormat);		
			title.x = stage.stageWidth / 2 - title.textWidth /2;
			title.y = stage.stageHeight / 2 - title.textHeight - 30;
			title.mouseEnabled = false;
			addChild(title);
			
			player1 = new TextField();
			player1.embedFonts = true;
			player1.text = "Play against Ai";
			player1.autoSize = TextFieldAutoSize.CENTER;
			player1.setTextFormat(subFormat);
			player1.x = stage.stageWidth / 2 - player1.textWidth / 2;
			player1.y = stage.stageHeight / 2 - player1.textHeight;
			/*player1.mouseEnabled = false;*/
			player1.addEventListener(MouseEvent.CLICK, vsAI);
			addChild(player1);
			
			player2 = new TextField();
			player2.embedFonts = true;
			player2.text = "Play against Player2";
			player2.autoSize = TextFieldAutoSize.CENTER;
			player2.setTextFormat(subFormat);
			player2.x = stage.stageWidth / 2 - player2.textWidth / 2;
			player2.y = stage.stageHeight / 2 ;
			/*player2.mouseEnabled = false;*/
			player2.addEventListener(MouseEvent.CLICK, vsPL);
			addChild(player2);
			
			shooter = new TextField();
			shooter.embedFonts = true;
			shooter.text = "Shooter Mode";
			shooter.autoSize = TextFieldAutoSize.CENTER;
			shooter.setTextFormat(subFormat);
			shooter.x = stage.stageWidth / 2 - shooter.textWidth / 2;
			shooter.y = stage.stageHeight / 2 + 30;
			shooter.addEventListener(MouseEvent.CLICK, setSHTR);
			addChild(shooter);
			
			start = new TextField();
			start.embedFonts = true;
			start.text = "press space to start";
			start.autoSize = TextFieldAutoSize.CENTER;
			start.setTextFormat(subFormat)
			start.x = stage.stageWidth / 2 - start.textWidth / 2;
			start.y = stage.stageHeight /2 + 100;
			start.mouseEnabled = false;
			addChild(start);
			
			start.addEventListener(Event.ENTER_FRAME, loop);
			
			
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == 32) {
				start.removeEventListener(Event.ENTER_FRAME, loop);		
				stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				dispatchEvent(new Event(START_GAME));
				
			}
		}
			
		private var dir:Boolean = true;
		private function loop(e:Event):void 
		{
			if (dir)
			{
				start.alpha -= .1;	
				if (start.alpha <= 0) dir = false;
				
			}else
			{
				start.alpha += .1;	
				if (start.alpha >= 1) dir = true;
			}
			
			
		}
		
	}

}