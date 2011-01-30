package  
{
	/**
	 * ...
	 * @author kedar
	 */
	import org.flixel.*;
	public class CreditsState extends FlxState
	{
		
		[Embed(source = "../content/creditscreen.png")] protected var CreditsScreen:Class;
		
	public function CreditsState() 
		{

			var credit: FlxSprite = new FlxSprite(0, 0, CreditsScreen);
			add(credit);
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
				HoopAndStick.ResetGame();
			}
		}
		
	}

}