package  
{
	import org.flixel.*;
	public class FakeHoop extends MobileSprite
	{
		[Embed(source = "../content/Ring.png")] protected var HoopImage:Class;
		protected var LIFETIME:int = 240;
		protected var KILLTIME:int = 60;
		protected var killTimer:int = KILLTIME;
		
		protected var killStart:Boolean = false;
		
		public var life:int = LIFETIME;
		public var flickerStart:Boolean = false;
		public var shouldDie:Boolean = false;
		public var hoopSpeed:int = 130;
		
		public function FakeHoop(_X:int, _Y:int) 
		{
			super(_X, _Y);
			loadGraphic(HoopImage, true, true, 80, 68);
			addAnimation("roll", [0]);
			addAnimation("tip", [1, 2, 3, 4], 5, true);
			play("tip");
			
			acceleration.y = GRAVITY_ACCELERATION;
			
			ROLL_ACCELERATION = 300;
			FRICTION = 20;
			
			ground_buffer = 1;
		}
		
		public override function update():void
		{
			life--;
			
			if (onFloor)
			{
				velocity.x = 0;
			}
			
			if (life < 1 && !killStart)
			{
				KillSoon();
			}
			
			if (killStart)
			{
				killTimer--;
				if (killTimer < 1)
				{
					shouldDie = true;
				}
			}
			
			super.update();
		}
		
		public function KillSoon():void {
			flicker(2);
			killStart = true;
		}
	}

}