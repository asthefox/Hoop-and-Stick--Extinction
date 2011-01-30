package  
{
	import org.flixel.FlxSprite;
	public class Boxstacle extends FlxSprite
	{
		[Embed(source = "../content/crate_bottom.png")] protected var PixelImage:Class;
			
		public function Boxstacle(X:int, Y:int) 
		{
			super(X, Y+18, PixelImage);
			//this.scale.x = 2;
			//this.scale.y = 2;
			fixed = true;
		}
	}
}