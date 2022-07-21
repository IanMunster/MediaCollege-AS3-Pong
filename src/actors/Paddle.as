package actors 
{
	import flash.display.MovieClip;
	import screens.ConfigScreen;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Paddle extends MovieClip 
	{
		
		public function Paddle() 
		{
			if (ConfigScreen.shooter_Game) {
				addChild(new PaddleGs());
			} else {
				addChild(new PaddleG());
			}
			/*addChild(new PaddleArt());*/
			
		}
		
	}

}