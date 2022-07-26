package utils 
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author erwin henraat
	 * 
	 */
	public class Controller extends EventDispatcher
	{
		private var _up:Boolean;
		private var _down:Boolean;
		private var _fire:Boolean;
		private var _upKeyCode:int;
		private var _downKeyCode:int;
		private var _fireKeyCode:int;
		
		
		//public function Controller(stage:Stage, up:int = Keyboard.UP, down:int = Keyboard.DOWN, fire:int = Keyboard.SPACE)
		public function Controller(stage:Stage, up:int, down:int, fire:int) 
		{
			//trace("constructor Controll");
			_upKeyCode = up;
			_downKeyCode = down;
			_fireKeyCode = fire;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onUp);
			
		}
		public function get up():Boolean
		{
			return _up;	
			//trace("return up controller"); //test traces
		}
		public function get down():Boolean
		{
			return _down;
			//trace("return down controller"); //test traces
		}
		public function get fire():Boolean
		{
			return _fire;
			//trace("return fire controller"); //test traces
		}
		private function onUp(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				case _upKeyCode:
					_up = false;
					break;
				case _downKeyCode:
					_down = false;
					break;
				case _fireKeyCode:
					_fire = false;
					break;
				default:
						
				
			}
		}		
		private function onDown(e:KeyboardEvent):void 
		{		
			
			
			//trace ("knopje");
			switch(e.keyCode)
			{
				case _upKeyCode:
					_up = true;
					break;
				case _downKeyCode:
					_down = true;
					break;
				case _fireKeyCode:
					_fire = true;
					break;
				default:
				
				
			}
		}
		
	}

}