package  
{
	import org.flixel.*;
	public class TitleState extends FlxState
	{
		
		public function TitleState() 
		{
			var titleText : FlxText = new FlxText(FlxG.width / 2, 100, 600, "Title Menu. Very Inspiring & Perhaps Pensive");
			titleText.size = 16;
			titleText.alignment = "center";
			titleText.x -= titleText.width / 2;
			add(titleText);
			var promptText : FlxText = new FlxText(FlxG.width / 2, 200, 600, "Press Enter and Fear the Dice");
			promptText.size = 16;
			promptText.alignment = "center";
			promptText.x -= promptText.width / 2;
			add(promptText);
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