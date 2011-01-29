package  
{
	import org.flixel.FlxSprite;
	public class Pixel extends FlxSprite
	{
		[Embed(source = "../content/pixel.png")] protected var PixelImage:Class;
			
		public function Pixel(X:int, Y:int) 
		{
			super(X, Y, PixelImage);
		}
		
	}

}