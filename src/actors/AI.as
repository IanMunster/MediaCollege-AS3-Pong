package actors 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	//import screens.ConfigScreen;
	//import actors.Player;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class AI extends Paddle 
	{
		//private var _pcTarget:MovieClip = ;
		private var _target:Ball;
		private var _speed:Number = 0;
		private var _maxSpeed:Number = 12;
		private var _balls:Array;
		
		//public static const aiSHOOT:String = "aiSHOOT";
		
		public function set balls(b:Array):void
		{
			_balls = b;			
		}
		public function AI() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(Event.ENTER_FRAME, loop);	
			//this.addEventListener(Event.ENTER_FRAME, shootingAI);
		}
		private function getTarget():void
		{
			if (_target == null)_target = _balls[0];
			if(_balls.length>1){
				var closest:Ball = _balls[0];
				for (var i:int = 1; i < _balls.length; i++) 
				{
					var d:Number = _balls[i-1].x - _balls[i].x;
					if (d < 0) closest = _balls[i];
				}
				_target = closest;
			}
		}
		private function loop(e:Event):void 
		{
			getTarget();
									
			if(_target != null){
				if (_target.y < this.y - 20)_speed = -_maxSpeed;
				else if (_target.y > this.y + 20)_speed = _maxSpeed;
				else _speed = 0;
				this.y += _speed;
			}
		}
		/*private function shootingAI(e:Event):void
		{
			if(this.y == _players.y && ConfigScreen.shooter_Game)
			{
				trace ("Enemy vuur!");
				//dispatchEvent(new Event(aiSHOOT));
			}
		}*/
	}
}