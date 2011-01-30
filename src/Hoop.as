package  
{
	import org.flixel.*;
	
	public class Hoop extends MobileSprite
	{
		//Flixel content
		[Embed(source = "../content/hoop.png")] protected var HoopImage:Class;
			
		//Tweakable movement/physics variables
		protected var JUMP_ACCELERATION:Number = 330;
		
		protected static const SPIN_MULTIPLIER:Number = 9;
		protected static const SPIN_DRAG:Number = 500; //240;
		
		protected static const AIR_MOVEMENT_MULTIPLIER:Number = 0.5;
		//protected var HOOP_START_X:int = 100;
		//protected var HOOP_START_Y:int = 100;
		
		//State Machine!
		public static const STATE_GROUND:int = 0;
		public static const STATE_AIR:int = 1;
		public static const STATE_TIP:int = 2;
		public static const STATE_FALL:int = 3;		

		//Other hoop variables
		public var state : int = 0;			// State to keep track of how movement should work
		public var hit : Boolean = false;		
		public var bounced : Boolean = false;
		public var rot : Number = 0; 		// positive is clockwise
		
		
		
		public function Hoop(_X:int, _Y:int) 
		{
			super(_X, _Y);
			loadGraphic(HoopImage, true, true, 48, 48);
			
			//Setting animations
			addAnimation("roll", [0]);
			addAnimation("tip", [0]);
			addAnimation("fall", [0]);
			addAnimationCallback(AnimationHandler);
			
			
			//Initializing Physics - TWEAK VALUES HERE!
			state = STATE_AIR;
			acceleration.y = GRAVITY_ACCELERATION;
			
			ROLL_ACCELERATION = 300;
			FRICTION = 20;
		}
		
		public override function update():void
		{
			// Handle changing of states
			if (onFloor) {
				state = STATE_GROUND;
			}
			
			// Boost velocity in direction when kicked
			if (hit) {
				hit = false;
				if (velocity.y < 0)
				{
					state = STATE_AIR;
					onFloor = false;
				}
			}
			
			if (bounced) {
				bounced = false;
				state = STATE_AIR;
				onFloor = false;
			}
			
			// Handle spinning
			/*
			angularVelocity = velocity.x * SPIN_MULTIPLIER;
			angularDrag = SPIN_DRAG;
			if (state == STATE_GROUND && angularVelocity > -45 && angularVelocity < 45) {
				angle = 0;
				angularVelocity = 0;
			}
			*/
			
			/*
			if (state == STATE_AIR) FlxG.log("In air");
			else if (state == STATE_FALL) FlxG.log("Falling");
			else if (state == STATE_GROUND) FlxG.log("On Ground");
			else if (state == STATE_TIP) FlxG.log("Tipping");
			*/
			
			// Handle Animation
			if (state == STATE_GROUND && angularVelocity == 0) {
				play("tip");
			} else {
				play("roll");
			}
			
			super.update();
		}
		
		
		// This is called automatically when an animation is over.
		// It can have the hoop fall over after it's played a tipping animation for long enough
		
		public function AnimationHandler(_name:String, _fnum:uint, _fint:uint) : void
		{
			//if (state == STATE_GROUND && (_name == "tip"))// && (_fnum == 2))
			//{
				//state = STATE_FALL;
			//}
		}
		
	}

}