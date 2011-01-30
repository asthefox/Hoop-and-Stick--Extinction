﻿package  
{
	import flash.geom.Rectangle;
	import org.flixel.*;
	
	/////
	//
	//	This is the player character, or Boy With Stick (the hoop is a separate sprite).
	//	Since it extends MobileSprite, it uses pixel-level hit detection when colliding with platforms.
	//	This class contains the state system for player movement, along with the player input and animation.
	//
	/////
	public class Player extends MobileSprite
	{
		//Flixel content
		[Embed(source = "../content/PlayerAnim3.png")] protected var PlayerImage:Class;
		
		//Input buttons
		protected var BUTTON_JUMP:String = "W";
		protected var BUTTON_LEFT:String = "A";
		protected var BUTTON_RIGHT:String = "D";
		
		protected var BUTTON_STICK_LEFT:String = "LEFT";
		protected var BUTTON_STICK_RIGHT:String = "RIGHT";
		protected var BUTTON_STICK_UP:String = "UP";
		protected var BUTTON_STICK_DOWN:String = "DOWN";
		
		//Tweakable movement/physics variables
		protected static const PLAYER_RUN_SPEED:int = 200;
		protected static const JUMP_ACCELERATION:Number = 350;
		protected static const AIR_MOVEMENT_MULTIPLIER:Number = 0.75;
		protected static const FALL_THRESHHOLD:int = 1;
		//protected var PLAYER_START_X:int = 100;
		//protected var PLAYER_START_Y:int = 100;
		
		public static const HORIZONTAL_HIT_FORCE:Number = 100;
		public static const VERTICAL_HIT_FORCE:Number = 250;
		public static const VERTICAL_HIT_DAMPEN:Number = 0.5;
		
		//State Machine!
		public static const STATE_GROUND:int = 0;
		public static const STATE_JUMP:int = 1;
		public static const STATE_FALL:int = 2;
		public static const STATE_STUN:int = 3;
		public static const STATE_SWING:int = 4;
		
		//Other player variables
		public var state : int = 0;			// State to keep track of how movement and input should work
		public var stickDir : int = 0;		// Current direction that you're hitting the hoop in
		public static const NONE : int = -1;
		
		public function Player(_X:int, _Y:int)
		{
			super(_X, _Y);
			loadGraphic(PlayerImage, true, true, 50, 100);
			
			//Setting animations
			addAnimation("idle", [6]);
			addAnimation("run", [0, 1, 2, 3, 4, 5], 5); 
			addAnimation("jump", [7]);
			addAnimation("fall", [0]);
			addAnimation("swing", [8, 9, 10, 10, 0], 5, false);
			addAnimation("stun", [0]);
			addAnimationCallback(AnimationHandler);
			
			//Setting physics
			state = STATE_GROUND;
			drag.x = PLAYER_RUN_SPEED * 8;
			maxVelocity.x = PLAYER_RUN_SPEED;
			maxVelocity.y = JUMP_ACCELERATION;
			acceleration.y = GRAVITY_ACCELERATION;
			ground_buffer = 11;

			ROLL_ACCELERATION = 0;
			FRICTION = 0;
		}
		
		public override function update():void
		{		
			//Jumping/Falling/Landing state machine
			if (FlxG.keys.justPressed(BUTTON_JUMP) && state == STATE_GROUND) {
				//Jump!
				//FlxG.play(SndJump);
				velocity.y = -JUMP_ACCELERATION;
				state = STATE_JUMP;
				onFloor = false;
			}
			
			else if (onFloor && (state == STATE_FALL || state == STATE_JUMP))
			{
				//Land!
				//FlxG.play(SndLand, 0.8);
				state = STATE_GROUND;
			}
						
			//Handle movement for jumping state
			if (state == STATE_JUMP)
			{
				play("jump");
				acceleration.x = 0;
				if (FlxG.keys.pressed(BUTTON_LEFT)) { 
					force_acceleration = -drag.x * AIR_MOVEMENT_MULTIPLIER; 
				}
				else if (FlxG.keys.pressed(BUTTON_RIGHT)) {
					force_acceleration = drag.x * AIR_MOVEMENT_MULTIPLIER;
				}
			}
			
			//Handle movement for falling state
			if (state == STATE_FALL)
			{
				if (FlxG.keys.pressed(BUTTON_LEFT)) { 
					force_acceleration = -drag.x * AIR_MOVEMENT_MULTIPLIER; 
				}
				else if (FlxG.keys.pressed(BUTTON_RIGHT)) {
					force_acceleration = drag.x * AIR_MOVEMENT_MULTIPLIER;
				}
			}
			
			//Handle movement for ground state
			if (state == STATE_GROUND)
			{
				force_acceleration = 0;
				if (FlxG.keys.pressed(BUTTON_LEFT)) { 
					facing = LEFT; 
					force_acceleration = -drag.x; 
				}
				else if (FlxG.keys.pressed(BUTTON_RIGHT)) {
					facing = RIGHT;
					force_acceleration = drag.x;
				}
			}
			
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
			
			//Super-Verbose Debug
			
			if (state == STATE_SWING) FlxG.log("Swinging");
			else if (state == STATE_FALL) FlxG.log("Falling");
			else if (state == STATE_GROUND) FlxG.log("On Ground");
			else if (state == STATE_JUMP) FlxG.log("Jumping");
			else if (state == STATE_STUN) FlxG.log("Stunned");
			
			
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
		
		public override function Fall():void { if (state != STATE_JUMP && state != STATE_SWING) { state = STATE_FALL; }}
		
		// This is called automatically when an animation is over.
		// It can tell the Player to automatically go back to a standing state after completing the stick swing animation.
		public function AnimationHandler(_name:String, _fnum:uint, _fint:uint) : void
		{
			if (state == STATE_SWING && (_name == "swing") && (_fnum >= 3))
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