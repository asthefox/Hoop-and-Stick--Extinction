package  
{
	public class Hoop extends MobileSprite
	{
		//Flixel content
		[Embed(source = "../content/hoop.png")] protected var HoopImage:Class;
			
		//Tweakable movement/physics variables
		protected static const HOOP_ROLL_SPEED:int = 100;
		protected static const JUMP_ACCELERATION:Number = 330;
		
		protected static const SPIN_MULTIPLIER:Number = 9;
		protected static const SPIN_DRAG:Number = 500; //240;
		protected static const FRICTION:Number = 40;
		
		protected static const AIR_MOVEMENT_MULTIPLIER:Number = 0.5;
		protected var HOOP_START_X:int = 100;
		protected var HOOP_START_Y:int = 100;
		
		//State Machine!
		public static const STATE_GROUND:int = 0;
		public static const STATE_AIR:int = 1;
		public static const STATE_TIP:int = 2;
		public static const STATE_FALL:int = 3;		

		//Other hoop variables
		public var state : int = 0;			// State to keep track of how movement should work
		public var hit : Boolean = false;		
		public var bounced : Boolean = false;
		//public var dx : Number = 0;
		//public var dy : Number = 0;
		public var rot : Number = 0; 		// positive is clockwise
		
		
		
		public function Hoop() 
		{
			super(HOOP_START_X, HOOP_START_Y);
			loadGraphic(HoopImage, true, true, 48, 48);
			
			//Setting animations
			addAnimation("roll", [0]);
			addAnimation("tip", [0]);
			addAnimation("fall", [0]);
			addAnimationCallback(AnimationHandler);
			
			
			//Initializing Physics
			state = STATE_AIR;
			acceleration.y = GRAVITY_ACCELERATION;
		}
		
		public override function update():void
		{
			acceleration.x = 0;
			//angularAcceleration = 0;
			//angularDrag = 0;
			
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
					//velocity.x = dx;
					//velocity.y = dy;
					onFloor = false;
				}
			}
			
			if (bounced) {
				bounced = false;
				state = STATE_AIR;
				//velocity.x = dx;
				//velocity.y = dy;
				onFloor = false;
			}
			
			// Apply Gravity
			acceleration.y = GRAVITY_ACCELERATION;
			
			// Handle States (friction mostly)
			if (state == STATE_GROUND) {

				acceleration.y = 0;
				velocity.y = 0;
				
				//FlxG.log("Ball Down!!!!!!!!");
				if (velocity.x > 0) {
					acceleration.x = -FRICTION;
				} else if (velocity.x < 0) {
					acceleration.x = FRICTION;
				}
			}
			
			if (state == STATE_AIR) {
				
			}
			
			// Handle spinning
			
			angularVelocity = velocity.x * SPIN_MULTIPLIER;
			angularDrag = SPIN_DRAG;
			if (state == STATE_GROUND && angularVelocity > -45 && angularVelocity < 45) {
				angle = 0;
				angularVelocity = 0;
			}
			
			
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