﻿package  
{
	import org.flixel.*;
	public class Boss extends FlxGroup
	{
		[Embed(source = "../content/Boss.png")] protected var BossImage:Class;
		
		public const BOSS_AREA_X : int = 650; //length of X range the boss will move around in //(6400-200) - 5550
		public const WAIT_TIME : int = 20;
		public const WINDUP_TIME : int = 80;
		public const ALTITUDE : int = 920; //default flight altitude
		public const ALTITUDE_GROUND : int = 1120;
		
		public var mainBody : FlxSprite;
		public var weakPoint : FlxSprite;
		
		public var bossHealth : int = 3;
		public var moveSpeed : Number = 3;
		public var destination : FlxPoint; //used when he chooses to fly somewhere. null otherwise
		public var destSet : Boolean = false;
		public var waitTimer : int = WAIT_TIME;
		public var windupTimer : int = WINDUP_TIME;
		
		//State Machine!
		public static const STATE_CHOOSING:int = 0; //picking what action to take next
		public static const STATE_FLYING:int = 1; //fly around
		public static const STATE_LAUGHING:int = 2; //laugh sound
		public static const STATE_DAMAGED:int = 3; //just got hit
		public static const STATE_VULNERABLE:int = 4; //vulnerable to hit
		public static const STATE_HOOPS:int = 5; // toss fake hoops
		public static const STATE_LANDING:int = 6; // land in prep for charging
		public static const STATE_WINDUP:int = 7; // prep for charging
		public static const STATE_CHARGE:int = 8; // attack!
		public static const STATE_PRELANDING:int = 9; // land in prep for charging
		public static const STATE_PRECHARGE:int = 10; // attack!
		//public static const STATE_PRETAKE:int = 5;
		//public static const STATE_TAKE:int = 6;
		//public static const STATE_PRETRAP:int = 7;
		//public static const STATE_TRAP:int = 8;
		
		public static const STATE_PREFLYING:int = 10;
		public static const STATE_IDLE:int = 11;
		
		public var state : int = STATE_CHOOSING;		
		
		//TODO: BOSS FIGHT LIST
		/*
		BASIC MOVEMENT
		decide which move to use
		MOVE: DROP HOOPS + TELL
		MOVE: TAKE HOOP + TELL
		MOVE: DROP TRAP + TELL
		SPOTLIGHT
		DARKEN THE LEVEL
		
		*/
		
		//NOTES
		/*
		The current movement code is a rush job. Not using acceleration. Just changing x values to move around 
		
		
		 */
		
		public function Boss(_X:int, _Y:int = ALTITUDE) 
		{
			super();
			x = _X;
			y = _Y;
			
			destination = new FlxPoint(_X, _Y);
			
			mainBody = new FlxSprite(0, 0);
			mainBody.loadGraphic(BossImage, true, true, 200, 200);
			mainBody.addAnimation("fly", [0, 1, 2, 3], 6, true);
			mainBody.addAnimation("hoops", [4, 5, 6, 7], 6, false);
			mainBody.addAnimation("windup", [7, 6, 5, 4], 8, true);
			mainBody.addAnimation("charge", [8, 9, 10, 11], 6, true);
			mainBody.addAnimation("vulnerable", [2], 0, false);
			add(mainBody);
			mainBody.play("fly");
			mainBody.solid = false;
			
			weakPoint = new FlxSprite(100,60);
			weakPoint.createGraphic(100, 20, 0xffff0088);
			add(weakPoint);
		}
		
		public override function update() : void
		{
			super.update();
			
			switch (state)
			{
				case STATE_CHOOSING:
					Choose();
					break;
				case STATE_PREFLYING:
					PreFly();
					break;
				case STATE_FLYING:
					MoveTo();
					break;
				case STATE_PRELANDING:
					SetDestination();
					state = STATE_LANDING;
					break;
				case STATE_LANDING:
					MoveTo();
					break;
				case STATE_WINDUP:
					WindUp();
					break;
				case STATE_PRECHARGE:
					SetDestination();
					state = STATE_CHARGE;
					break;
				case STATE_CHARGE:
					MoveTo();
					break;
			}
			
			if (state == STATE_FLYING || state == STATE_PREFLYING)
			{
				HandleFacing();
			}
			
			//mainBody.x += 2;
			//weakPoint.x += 2;
		}
		
		public function Choose() : void
		{
			FlxG.log("choosing");
			var decision : Number = Math.random() * 100;
			
			if (decision < 50) {
				state = STATE_PREFLYING;//(decision < 50) state = STATE_PREFLYING; //always. later, 50% chance he'll just prepare to fly to a point
				FlxG.log("chose to fly");
			}
			else if (decision < 101) 
			{
				state = STATE_PRELANDING; //(decision < 60) state = STATE_LANDING; // land for attack
				FlxG.log("chose to attack");
			}
			//else if (decision < 70) state = STATE_LAUGHING; //20% chance he'll pause to gloat
			//else if (decision < 80) state = STATE_PREHOOPS; //10% chance he'll prepare to drop hoops
			//else if (decision < 90) state = STATE_PRETAKE; //10% chance he'll prepare to take your hoop
			else state = STATE_FLYING;
		}
		
		public function PreFly() : void
		{
			if (!destSet) 
			{
				SetDestination();
			}
			else
			{
				waitTimer--;
				if (waitTimer < 1) 
				{
					state = STATE_FLYING;
					waitTimer = WAIT_TIME;
					destSet = false;
				}
			}
			
		}
		
		public function SetDestination() : void
		{
			var theX : int = 5550 + Math.random() * BOSS_AREA_X;
			destination.x = theX;
			if (state == STATE_PRELANDING || STATE_CHARGE)
			{
				destination.y = ALTITUDE_GROUND;
			}
			else 
			{
				destination.y = ALTITUDE;
			}
			destSet = true;
			FlxG.log("new boss destination: (" + destination.x + ", " + destination.y + ")");
		}
		
		public function MoveTo() : void
		{
			var toGo : int = destination.x - mainBody.x;
			var YtoGo : int = destination.y - mainBody.y;
			
			if ((toGo < moveSpeed) && (toGo > -moveSpeed))
			{
				if (state == STATE_FLYING)
				{
					destination.x = -1000;
					state = STATE_CHOOSING;
				}
				else if (state == STATE_LANDING)
				{
					destination.x = -1000;
					state = STATE_WINDUP;
				}
			}
			else 
			{
				mainBody.x += moveSpeed * ((destination.x - mainBody.x) / Math.abs(destination.x - mainBody.x));
				weakPoint.x += moveSpeed * ((destination.x - mainBody.x) / Math.abs(destination.x - mainBody.x));
				
				if (!(YtoGo < moveSpeed && YtoGo > -moveSpeed))
				{
				mainBody.y += moveSpeed * ((destination.y - mainBody.y) / Math.abs(destination.y - mainBody.y));
				weakPoint.y += moveSpeed * ((destination.y - mainBody.y) / Math.abs(destination.y - mainBody.y));
				}
			}
		}
		
		public function WindUp() : void
		{
			mainBody.play("windup");
			
			windupTimer--;
			if (windupTimer < 1)
			{
				state = STATE_PRECHARGE;
				windupTimer = WINDUP_TIME;
			}
		}
		
		public function HandleFacing() : void
		{
			if (mainBody.x + mainBody.width / 2 > Player.LOCATION.x + 25)
			{
				mainBody.facing = FlxSprite.LEFT;
				weakPoint.x = mainBody.x;
			}
			else
			{
				mainBody.facing = FlxSprite.RIGHT;
				weakPoint.x = mainBody.x + 100;
			}
			
		}
		
	}

}