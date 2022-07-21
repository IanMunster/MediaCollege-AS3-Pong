package actors 
{
	import flash.display.MovieClip;
	import utils.Controller;	
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	import screens.ConfigScreen;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Player extends Paddle 
	{
		private var controller:Controller;
		private var speed:Number = 0;
		private var _up:int;
		private var _down:int;
		private var _fire:int;
		public var maxSpeed:Number;
		
		public static const SHOOT:String = "SHOOT";
		
		public function get _maxSpeed():Number
		{
			return maxSpeed;
			
		}
		public function set _maxSpeed(value:Number):void
		{
			if (value > 30)
			{
				trace("maxspeed cannot be more than 30!");
			}
			else {
				maxSpeed = value;
			}
		}
		
		public function Player(up:int,down:int,fire:int) 
		{
			
			_up = up;
			_down = down;
			_fire = fire;
			//trace("controllers werkend"); //test traces
			this.addEventListener(Event.ADDED_TO_STAGE, init);		
		}		
		private function init(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			controller = new Controller(stage,_up,_down,_fire);
			//trace("Added Controller player"); /*Test Traces*/
			this.addEventListener(Event.ENTER_FRAME, loop);			
		}
		private function loop(e:Event):void 
		{
			if (controller.up)
			{
				/*speed = -15;*/
				speed = -maxSpeed;
				//trace("if controller up"); //test traces
			}
			else if(controller.down)
			{
				/*speed = 15;*/
				speed = maxSpeed;
				//trace("if controller down"); //test traces
			}else
			{
				if (speed > 0) speed--;
				if (speed < 0) speed++;
				//trace("else controller"); //test traces
				
			}
			if (controller.fire && ConfigScreen.shooter_Game)
			{
				trace ("vuur!");
				dispatchEvent(new Event(SHOOT));
			}
			
			this.y += speed;
		}
		
	}

}