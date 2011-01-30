package  
{
	import org.flixel.*;
	public class EndingState extends FlxState
	{
		[Embed(source = "../content/winscreen.png")] protected var WinScreen:Class;
		[Embed(source = "../content/endscreen.png")] protected var EndScreen:Class;
		public function EndingState() 
		{
			if (PlayState.end == true) {
				var end1: FlxSprite = new FlxSprite(0, 0, EndScreen);
				add(end1);
			}
			else{
				var end2: FlxSprite = new FlxSprite(0, 0, WinScreen);
				add(end2);
			}
			
			
			/*var titleText : FlxText = new FlxText(FlxG.width / 2, 100, 600, "Ending Cutscene/Credits?");
			titleText.size = 16;
			titleText.alignment = "center";
			titleText.x -= titleText.width / 2;
			add(titleText);
			var titleText2 : FlxText = new FlxText(FlxG.width / 2, 200, 600, "Man. I am moved.");
			titleText2.size = 16;
			titleText2.alignment = "center";
			titleText2.x -= titleText2.width / 2;
			add(titleText2);
			var promptText : FlxText = new FlxText(FlxG.width / 2, 300, 600, "Press Enter to do it again");
			promptText.size = 16;
			promptText.alignment = "center";
			promptText.x -= promptText.width / 2;
			add(promptText);*/
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