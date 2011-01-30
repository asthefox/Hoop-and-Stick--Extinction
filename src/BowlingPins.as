package  
{
	import org.flixel.FlxSprite;

	public class BowlingPins extends FlxSprite
	{
		[Embed(source = "../content/bottlessheet.png")] protected var PinImage:Class;
		
		public function BowlingPins(_X:int, _Y:int) 
		{
			super(_X, _Y);
			loadGraphic(PinImage, true, true, 240, 150);
			
			addAnimation("bottles", [0]);
			addAnimation("pinSmash", [0, 1, 2, 3, 4, 5], 10, true);
			play("bottles");
		}
		
		public override function update() : void
		{
			if (_curFrame == 5)
			{
				//visible = false;
				kill();
			}
			else if(_curAnim.name != "pinSmash")
			{
				play("bottles");
			}
			
			super.update();
		}
		
		public function strike() : void
		{
			play("pinSmash");
		}
		
	}

}