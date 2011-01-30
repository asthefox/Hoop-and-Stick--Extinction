package  
{
	import org.flixel.*;
	public class InstructionState extends FlxState
	{
		
		[Embed(source = "../content/instructscreen.png")] protected var InstructImage:Class;
		
		public var instructScreen : FlxSprite = new FlxSprite(0, 0, InstructImage);
		
		public function InstructionState() 
		{
			add(instructScreen);
		}
		
		public override function create():void
		{
			FlxG.flash.start(0xFF000000);
		}
		
		public override function update():void
		{
			CheckInput();
		}
		
		private function CheckInput() : void
		{	
			if (FlxG.keys.justPressed("ENTER"))
			{
				HoopAndStick.GetNextState();
			}
		}
		
	}

}