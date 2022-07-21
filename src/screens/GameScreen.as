package screens 
{
	import actors.AI;
	import actors.Ball;
	import actors.Paddle;
	import actors.Player;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import utils.MovementCalculator;
	import screens.Scoreboard;
	import flash.ui.Keyboard;
	
	import utils.Controller;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameScreen extends Screen
	{
		private var balls:Array = [];
		private var paddles:Array = [];
		private var bullets:Array = [];
		private var scoreboard:Scoreboard;
		static public const GAME_OVER:String = "game over";
		static public const BALL_BOUNCE:String = "ballBounce";
		/*Probeerseltje*/
		public function GameScreen() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);			
		}				
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
				/*for (var i:int = 0; i < 2; i++)*/
				for (var i:int = 0; i < 1; i++) 
			{
				balls.push(new Ball());
				addChild(balls[i]);
				balls[i].reset();
				
				balls[i].addEventListener(Ball.OUTSIDE_RIGHT, onRightOut);
				balls[i].addEventListener(Ball.OUTSIDE_LEFT, onLeftOut);
				
			}
			/*
			paddles.push(new AI());
			paddles.push(new Player());*/
			
			/*Probeerseltje*/
			stage.focus = this.parent as MovieClip;
			//stage.focusRect = false;
			
			trace("VS P2 = " + ConfigScreen.vs_P2);//test trace
			if (ConfigScreen.vs_P2) {
				paddles.push(new Player(Keyboard.UP, Keyboard.DOWN, Keyboard.SPACE));
				paddles[0]._maxSpeed = 10;
				paddles.push(new Player(Keyboard.W, Keyboard.S, Keyboard.SHIFT));
				
				paddles[0].addEventListener(Player.SHOOT, createBullet);
				paddles[1].addEventListener(Player.SHOOT, createBullet);
				trace("selected vsP2"); //test traces
			} else {
				paddles.push(new AI());
			    paddles.push(new Player(Keyboard.UP, Keyboard.DOWN, Keyboard.SPACE));
				paddles[0].balls = balls;
				
				//paddles[2].addEventListener(AI.aiSHOOT, createBullet);
				paddles[1].addEventListener(Player.SHOOT, createBullet);
				trace("selected vsAI"); //test traces
			}
			/*Probeerseltje*/
			
			paddles[1]._maxSpeed = 10;
			
			
			for (i = 0; i < 2; i++) 
			{
				addChild(paddles[i]);
				paddles[i].y = stage.stageHeight / 2;
			}	
			paddles[0].x = stage.stageWidth - 100;
			
			
			paddles[1].x = 100;
			paddles[0].scaleX = -1;
			
			
			scoreboard = new Scoreboard();
			addChild(scoreboard);
			
			this.addEventListener(Event.ENTER_FRAME, loop);
		}		
		
		private function loop(e:Event):void 
		{
			checkCollision();
			checkHit();
		}
		
		private function checkCollision():void 
		{
			for (var i:int = 0; i < balls.length; i++) 
			{
				for (var j:int = 0; j < paddles.length; j++) 
				{
					if (paddles[j].hitTestObject(balls[i]))
					{
						balls[i].xMove *= -1;
						var dir:Number = balls[i].xMove / Math.abs(balls[i].xMove);
						while (paddles[j].hitTestObject(balls[i]))
						{
							balls[i].x += dir;
							
						}
						
						balls[i].x += balls[i].xMove / 2;
						
						dispatchEvent(new Event(BALL_BOUNCE));
					}
				}
			}
			
		}
		private function onLeftOut(e:Event):void 
		{
			var b:Ball = e.target as Ball;
			b.reset();
			
			scoreboard.player2 += 1;
			
			checkScore();
		}		
		private function onRightOut(e:Event):void 
		{
			var b:Ball = e.target as Ball;
			b.reset();
			scoreboard.player1 += 1;
			
			
			checkScore();
		}	
		
		private function createBullet(e:Event):void
		{
			//trace("createBullet"); //test trace
			var make_bullet:MovieClip = new Bullet();
			bullets.push(make_bullet);
				if (e.currentTarget == paddles[0])
				{
				//trace("P1 Bullet ready"); //test trace
				make_bullet.x = e.currentTarget.x - 20;
				make_bullet.y = e.currentTarget.y;
				addChild(make_bullet);
				make_bullet.addEventListener(Event.ENTER_FRAME, move_bullet_p2);
				//make_bullet.addEventListener(Event.ENTER_FRAME, destroy_bullet);
				}
				if (e.currentTarget == paddles[1])
				{
				//trace("P2 Bullet ready"); //test trace
				make_bullet.x = e.currentTarget.x + 20;
				make_bullet.y = e.currentTarget.y;
				addChild(make_bullet);
				make_bullet.addEventListener(Event.ENTER_FRAME, move_bullet_p1);
				//make_bullet.addEventListener(Event.ENTER_FRAME, destroy_bullet);
				}
				if (e.currentTarget == paddles[2])
				{
				trace("AI Bullet ready"); //test trace
				make_bullet.x = e.currentTarget.x - 20;
				make_bullet.y = e.currentTarget.y;
				addChild(make_bullet);
				make_bullet.addEventListener(Event.ENTER_FRAME, move_bullet_p2);
				//make_bullet.addEventListener(Event.ENTER_FRAME, destroy_bullet);
				}
			//make_bullet.addEventListener(Event.ENTER_FRAME, destroy_bullet);
	
			function move_bullet_p1(e:Event):void
			{
				make_bullet.x += 10;
				//trace("P1 Bullet moving"); //test trace
			}
			function move_bullet_p2(e:Event):void
			{
				make_bullet.x -= 10;
				//trace("P2 Bullet moving"); //test trace
			}
		}
		
		private function checkHit():void
		{
			for (var p:int = 0; p < paddles.length; p++)
				{
					for (var b:int = 0; b < bullets.length; b++)
					{
						if (paddles[1].hitTestObject(bullets[b]))
						{
							scoreboard.player1 --;
							//destroy_bullet();
						}
						if (paddles[0].hitTestObject(bullets[b]))
						{
							scoreboard.player2 --;
							//destroy_bullet();
						}
					}
				}
		}
		/*private function destroy_bullet():void
		{
			for (var bd:int = 0; bd < bullets.length; bd++ )
			{
				bullets[bd].removeEventListener;
				removeChild(bullets.bd)
			}
			bullets.splice(0, bullets.length);
		}
		*/
		private function checkScore():void 
		{
			/*if (scoreboard.player1 >= 10 || scoreboard.player2 >= 10)*/
			if (scoreboard.player1 >= 10 || scoreboard.player2 >= 20)
			{
				destroy();
				dispatchEvent(new Event(GAME_OVER));
				
			}
			
		}
			
		private function destroy():void
		{
			for (var i:int = 0; i < balls.length; i++) 
			{
				balls[i].destroy();
				removeChild(balls[i]);
			}
			balls.splice(0, balls.length);
		}
	}

}