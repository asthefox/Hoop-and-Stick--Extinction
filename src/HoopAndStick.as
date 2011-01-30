package  
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="640", height="480", backgroundColor="#000000")] //Set the size and color of the Flash file

	
	public class HoopAndStick extends FlxGame
	{
		public static const TITLE : int = 0;
		public static const INTRO : int = 1;
		public static const LEVEL1 : int = 2;
		public static const ENDING : int = 3;
		
		public static var StateTypes : Array;
		public static var StatePointer : int = 0;
		
		
		public function HoopAndStick() 
		{
			//TODO: Change opening State to TitleState when it's ready
			super(640, 480, PlayState, 1);
			
			StateTypes = new Array();
			StateTypes[TITLE] = TitleState;
			StateTypes[INTRO] = IntroState;
			StateTypes[LEVEL1] = PlayState;
			StateTypes[ENDING] = EndingState;
		}
		
		public static function ResetGame() : void
		{
			StatePointer = 0;
			FlxG.state = new StateTypes[StatePointer]();
		}
		
		public static function GetNextState() : void
		{
			StatePointer++;
			FlxG.state = new StateTypes[StatePointer]();
		}
	}

}