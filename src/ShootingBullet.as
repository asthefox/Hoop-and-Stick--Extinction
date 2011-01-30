package  
{
	import org.flixel.*;
	public class ShootingBullet extends FlxSprite
	{
		[Embed(source = "../content/paintdrop.png")] protected var BulletImage:Class;
		
		protected var dx : int = 0;
		protected var dy : int = 0;
		protected var target : FlxSprite;
		protected var VELOCITY : int = 7;
		
		public function ShootingBullet(X:int, Y:int, _target:FlxSprite, painted:Boolean)
		{
			super(X, Y, BulletImage);
			target = _target;
			
			var angle : Number = FlxU.getAngle(target.x + target.width/2 - (x + (width / 2)), target.y + target.height/2 - (y + (height / 2)));
			//FlxG.log("angle is " + angle + " degrees.");
			angle = (angle * (Math.PI / 180));
			if (angle < Math.PI/2 && angle > -1 * Math.PI/2)
			{
				facing = RIGHT;
			}
			else
			{
				facing = LEFT;
			}
			
			dx = Math.cos(angle) * (VELOCITY);
			dy = Math.sin(angle) * (VELOCITY);
			
			if (painted)
			{
				switch(Math.floor(FlxU.random()*6))
				{
					case(0):
						color = 0xff0000;
					break;
					case(1):
						color = 0xffff00;
					break;
					case(2):
						color = 0xff00ff;
					break;
					case(3):
						color = 0x00ffff;
					break;
					case(4):
						color = 0x00ff00;
					break;
					case(5):
						color = 0x0000ff;
					break;
				}
			}
		}
		
		public override function update():void
		{
			x += dx;
			y += dy;
			
			if (FlxHitTest.complexHitTestObject(this, (FlxG.state as PlayState).level1.shootingSituation.button))
			{
				(FlxG.state as PlayState).level1.shootingSituation.Open();
				this.kill();
			}
			else if (overlaps((FlxG.state as PlayState).hoop))
			{
				(FlxG.state as PlayState).level1.shootingSituation.Happy();
			}
			else if (x > ((FlxG.state as PlayState).level1.shootingSituation.obstacle.x))
			{
				this.kill();
			}
			
		}
		
	}

}