package  
{
	import org.flixel.*;
	public class TitleState extends FlxState
	{
		
		[Embed(source = "../content/titlescreen.png")] protected var TitleScreen:Class;
		
		public function TitleState() 
		{
			var title1: FlxSprite = new FlxSprite(0, 0, TitleScreen);
			add(title1);
			/*var titleText : FlxText = new FlxText(FlxG.width / 2, 100, 600, "Title Menu. Very Inspiring & Perhaps Pensive");
			titleText.size = 16;
			titleText.alignment = "center";
			titleText.x -= titleText.width / 2;
			add(titleText);*/
			var promptText : FlxText = new FlxText(FlxG.width / 2, 310, 1300, "Press Enter and Fear the Dice");
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