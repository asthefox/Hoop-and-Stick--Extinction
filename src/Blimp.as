package  
{
	import org.flixel.*;
	public class Blimp extends FlxSprite
	{
		[Embed(source = "../content/blimp.png")] protected var BlimpImage:Class;
		
		public function Blimp(_X:int, _Y:int) 
		{
			super(_X, _Y);
			loadGraphic(BlimpImage, false, true);
			scrollFactor.y = 1;
			scrollFactor.x = 1;
			solid = false;
		}
		
		public override function update() : void
		{
			super.update();
			
			if (facing == LEFT)
			{
				x -= 0.7;
			}
			else if (facing == RIGHT)
			{
				x += 0.7;
			}
		}
		
	}

}