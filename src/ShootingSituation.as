package  
{
	import org.flixel.*;
	public class ShootingSituation extends FlxGroup
	{
		[Embed(source = "../content/paint_scaffold.png")] protected var ScaffoldImage:Class;
		
		public var cannon : ShootingCannon;
		public var guy : ShootingGuy;
		public var target : FlxSprite;
		public var obstacle : ShootingObstacle;
		public var scaffold : FlxSprite;
		public var button : ShootingButton;
		
		public var activated : Boolean = false;
		public var happy : Boolean = false;
		public var completed : Boolean = false;
		
		public var timer : int = 0;
		public var timerMax : int = 120;
		
		public function ShootingSituation() 
		{
			add(new Boxstacle(30, 180));
			add(new Boxstacle(90, 180));
			add(new BoxstacleTop(30, 180));
			add(new BoxstacleTop(90, 180));
			
			cannon = new ShootingCannon(90,130);
			add(cannon);
			
			guy = new ShootingGuy(40,100);
			add(guy);
			
			obstacle = new ShootingObstacle(500,130);
			add(obstacle);
			
			scaffold = new FlxSprite(500, 130, ScaffoldImage);
			add(scaffold);
			
			target = new ShootingTarget(500,20);
			add(target);
			
			add(new ShootingTarget(500,70));
			
			button = new ShootingButton(500,130);
			add(button);
			
		}
		
		public override function update():void
		{
			if(activated)
			{
				timer ++;
				if (timer >= timerMax)
				{
					timer = 0;
				
					//Shoot a thing!
					Shoot();
				}	
			}
			
			if (completed && obstacle != null && obstacle.exists)
			{
				obstacle.scale.y *= 0.95;
				obstacle.y ++;
				
				if (obstacle.y >= 180)
					obstacle.kill();
			}
			
			super.update();
		}
		
		public function Shoot() : void
		{
			add(new ShootingBullet(cannon.x + 50, cannon.y + 22, target, happy));
		}
		
		public function Happy() : void
		{
			happy = true;
			guy.isHappy = true;
			target = (FlxG.state as PlayState).hoop;
		}
		
		public function Open() : void
		{
			completed = true;
			button.isOpen = true;
			//obstacle.kill();
				
		}
	}

}