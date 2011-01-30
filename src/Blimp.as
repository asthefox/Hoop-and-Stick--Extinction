package  
{
	import org.flixel.*;
	public class Blimp extends FlxSprite
	{
		
		public function Blimp() 
		{
			loadGraphic(BlimpImage, false, true);
		}
		
		public override function update() : void
		{
			if (facing == LEFT)
			{
				x -= 1;
			}
			else if (facing == RIGHT)
			{
				x += 1;
			}
		}
		
	}

}