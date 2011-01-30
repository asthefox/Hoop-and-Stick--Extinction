package  
{
	import org.flixel.*;
	public class Boss extends FlxGroup
	{
		public const BOSS_AREA_X : int = 800; //length of X range the boss will move around in
		
		public var mainBody : FlxSprite;
		public var weakPoint : FlxSprite;
		
		public var bossHealth : int = 3;
		public var moveSpeed : int = 2;
		public var destination : int = 0; //used when he chooses to fly somewhere. null otherwise
		
		//State Machine!
		public static const STATE_FLYING:int = 0;
		public static const STATE_LAUGHING:int = 1;
		public static const STATE_DAMAGED:int = 2;
		public static const STATE_PREHOOPS:int = 3;
		public static const STATE_HOOPS:int = 4;
		public static const STATE_PRETAKE:int = 5;
		public static const STATE_TAKE:int = 6;
		public static const STATE_PRETRAP:int = 7;
		public static const STATE_TRAP:int = 8;
		public static const STATE_CHOOSING:int = 9; //picking what action to take next
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
		
		public function Boss(_X:int, _Y:int) 
		{
			super();
			x = _X;
			y = _Y;
			
			mainBody = new FlxSprite(0, 0);
			mainBody.createGraphic(200, 100, 0xff22eedd);
			add(mainBody);
			
			weakPoint = new FlxSprite(70,100);
			weakPoint.createGraphic(80, 20, 0xffff0088);
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
				
			}
			
			//mainBody.x += 2;
			//weakPoint.x += 2;
		}
		
		public function Choose() : void
		{
			FlxG.log("choosing");
			var decision : Number = Math.random() * 100;
			
			if (decision < 101) state = STATE_PREFLYING; //always. later, 50% chance he'll just prepare to fly to a point
			else if (decision < 70) state = STATE_LAUGHING; //20% chance he'll pause to gloat
			else if (decision < 80) state = STATE_PREHOOPS; //10% chance he'll prepare to drop hoops
			else if (decision < 90) state = STATE_PRETAKE; //10% chance he'll prepare to take your hoop
			else state = STATE_PRETRAP; //10% chance he'll prepare to drop a trap
		}
		
		public function PreFly() : void
		{
			var theX : int = Math.random() * BOSS_AREA_X;
			destination = theX;
			//FlxG.log("Target X: " + destination);
			
			FlxG.fade.start(0x00ffffff, 2, MoveTo);
			state = STATE_IDLE;
		}
		
		public function MoveTo() : void
		{
			//FlxG.log("moveto");
			//FlxG.log("destiny is " + destination);
			state = STATE_FLYING;
			var toGo : int = destination - mainBody.x;
			
			if (toGo < moveSpeed && toGo > -moveSpeed)
			{
				destination = -1000;
				state = STATE_CHOOSING;
			}
			else 
			{
				mainBody.x += moveSpeed * ((destination - mainBody.x) / Math.abs(destination - mainBody.x));
				weakPoint.x += moveSpeed * ((destination - mainBody.x) / Math.abs(destination - mainBody.x));
			}
			
			
			
			
			
		}
		
	}

}