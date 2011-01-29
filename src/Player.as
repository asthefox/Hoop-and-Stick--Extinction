package  
{
	import org.flixel.*;
	
	public class Player extends FlxSpritePP
	{
		//Flixel content
		[Embed(source = "../content/boy.png")] protected var PlayerImage:Class;
		
		//Input buttons
		protected var BUTTON_JUMP:String = "W";
		protected var BUTTON_LEFT:String = "A";
		protected var BUTTON_RIGHT:String = "D";
		
		protected var BUTTON_STICK_LEFT:String = "LEFT";
		protected var BUTTON_STICK_RIGHT:String = "RIGHT";
		protected var BUTTON_STICK_UP:String = "UP";
		protected var BUTTON_STICK_DOWN:String = "DOWN";
		
		//Tweakable movement/physics variables
		protected static const PLAYER_RUN_SPEED:int = 100;
		protected static const GRAVITY_ACCELERATION:Number = 820;
		protected static const JUMP_ACCELERATION:Number = 330;
		protected static const AIR_MOVEMENT_MULTIPLIER:Number = 0.5;
		protected var PLAYER_START_X:int = 100;
		protected var PLAYER_START_Y:int = 100;
		
		//State Machine!
		public static const STATE_GROUND:int = 0;
		public static const STATE_JUMP:int = 1;
		public static const STATE_FALL:int = 2;
		public static const STATE_STUN:int = 3;
		public static const STATE_SWING:int = 4;
		
		//Other player variables
		public var state : int = 0;			// State to keep track of how movement and input should work
		public var stickDir : int = 0;		// Current direction that you're hitting the hoop in
		
		public function Player()
		{
			super(PLAYER_START_X, PLAYER_START_Y, true);
			loadGraphic(PlayerImage, true, true, 48, 48);
			
			//Setting animations
			addAnimation("idle", [0]);
			addAnimation("run", [0, 0, 0, 0], 10); 
			addAnimation("jump", [0]);
			addAnimation("fall", [0]);
			addAnimation("swing", [0]);
			addAnimation("stun", [0]);
			addAnimationCallback(AnimationHandler);
			
			//Setting physics
			state = STATE_GROUND;
			drag.x = PLAYER_RUN_SPEED * 8;
			maxVelocity.x = PLAYER_RUN_SPEED;
			maxVelocity.y = JUMP_ACCELERATION;
			acceleration.y = GRAVITY_ACCELERATION;
		}
		
		public override function update():void
		{	
			//Checking input for stick hitting
			if (FlxG.keys.justPressed(BUTTON_STICK_UP))
			{
				if (state == STATE_JUMP || state == STATE_FALL || state == STATE_GROUND)
				{
					state = STATE_SWING;
					stickDir = UP;
				}
			}
			if (FlxG.keys.justPressed(BUTTON_STICK_DOWN))
			{
				if (state == STATE_JUMP || state == STATE_FALL || state == STATE_GROUND)
				{
					state = STATE_SWING;
					stickDir = DOWN;
				}
			}
			if (FlxG.keys.justPressed(BUTTON_STICK_LEFT))
			{
				if (state == STATE_JUMP || state == STATE_FALL || state == STATE_GROUND)
				{
					state = STATE_SWING;
					stickDir = LEFT;
				}
			}
			if (FlxG.keys.justPressed(BUTTON_STICK_RIGHT))
			{
				if (state == STATE_JUMP || state == STATE_FALL || state == STATE_GROUND)
				{
					state = STATE_SWING;
					stickDir = RIGHT;
				}
			}
			
			//Jumping/Falling/Landing state machine
			if (FlxG.keys.justPressed(BUTTON_JUMP) && state == STATE_GROUND) {
				//Jump!
				//FlxG.play(SndJump);
				velocity.y = -JUMP_ACCELERATION;
				state = STATE_JUMP;
			}
			else if (!velocity.y && (state != STATE_GROUND))
			{
				//Land!
				//FlxG.play(SndLand, 0.8);
				state = STATE_GROUND;
				acceleration.y = GRAVITY_ACCELERATION;
			}
			else if (state == STATE_GROUND && velocity.y != 0)
			{
				//Fall!
				state = STATE_FALL;
			}
			
			
			//Handle movement for jumping state
			if (state == STATE_JUMP)
			{
				acceleration.x = 0;
				if (FlxG.keys.pressed(BUTTON_LEFT)) { 
					acceleration.x = -drag.x * AIR_MOVEMENT_MULTIPLIER; 
				}
				else if (FlxG.keys.pressed(BUTTON_RIGHT)) {
					acceleration.x = drag.x * AIR_MOVEMENT_MULTIPLIER;
				}
			}
			
			//Handle movement for falling state
			if (state == STATE_FALL)
			{
				if (FlxG.keys.pressed(BUTTON_LEFT)) { 
					acceleration.x = -drag.x * AIR_MOVEMENT_MULTIPLIER; 
				}
				else if (FlxG.keys.pressed(BUTTON_RIGHT)) {
					acceleration.x = drag.x * AIR_MOVEMENT_MULTIPLIER;
				}
			}
			
			//Handle movement for ground state
			if (state == STATE_GROUND)
			{
				acceleration.x = 0;
				if (FlxG.keys.pressed(BUTTON_LEFT)) { 
					facing = LEFT; 
					acceleration.x = -drag.x; 
				}
				else if (FlxG.keys.pressed(BUTTON_RIGHT)) {
					facing = RIGHT;
					acceleration.x = drag.x;
				}
			}
			
			//Update animation based on state
			if (state == STATE_JUMP) {
				play("jump");
			} else if (state == STATE_FALL) { 
				play("fall"); 
			} else if (state == STATE_GROUND && velocity.x == 0) {
				play("idle"); 
			} else if (state == STATE_GROUND) {
				play("run");
			} else if (state == STATE_STUN) {
				play("stun");
			} else if (state == STATE_SWING) {
				play("swing");
			}
			
			super.update();
		}
		
		public function AnimationHandler(_name:String, _fnum:uint, _fint:uint) : void
		{
			if (state == STATE_SWING && (_name == "swing"))// && (_fnum == 2))
			{
				state = STATE_GROUND;
			}
			if (state == STATE_STUN && (_name == "stun"))// && (_fnum == 2))
			{
				state = STATE_GROUND;
			}
		}
		
	}

}