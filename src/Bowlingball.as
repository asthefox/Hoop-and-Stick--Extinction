package  
{
	import org.flixel.*;
	
	public class Bowlingball extends MobileSprite
	{
		//Flixel content
		[Embed(source = "../content/bowlballsheet.png")] protected var BowlballImage:Class;
			
		public var hit:Boolean = false;
		
		public function Bowlingball(_X:int, _Y:int) 
		{
			super(_X, _Y);
			loadGraphic(BowlballImage, true, true, 25, 25);
			
			scale.x = 2;
			scale.y = 2;
			
			//Setting animations
			addAnimation("idle", [0]);
			addAnimation("roll", [0,1,2,3,4],10,true);
			
			acceleration.y = GRAVITY_ACCELERATION;
			
			ROLL_ACCELERATION = 300;
			FRICTION = 20;
			
			ground_buffer = 1;
			
			fixed = true;
		}
		
		public override function update():void
		{
			if (hit)
			{
				velocity.x = 130;
				play("roll");
			}
			else
			{
				play("idle");
			}
			
			super.update();
		}
		
		
		// This is called automatically when an animation is over.
		// It can have the hoop fall over after it's played a tipping animation for long enough
		
		public function AnimationHandler(_name:String, _fnum:uint, _fint:uint) : void
		{

		}
		
	}

}