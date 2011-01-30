package  
{
	import org.flixel.FlxSprite;
	public class BoxstacleTop extends Platform
	{
		[Embed(source = "../content/crate_top.png")] protected var PixelImage:Class;
			
		public function BoxstacleTop(X:int, Y:int) 
		{
			super(X-25, Y, PixelImage);
			//this.scale.x = 2;
			//this.scale.y = 2;
		}
	}
}