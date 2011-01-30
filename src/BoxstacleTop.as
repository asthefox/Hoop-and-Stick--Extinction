package  
{
	import org.flixel.FlxSprite;
	public class BoxstacleTop extends Platform
	{
		[Embed(source = "../content/scaffold_top.png")] protected var PixelImage:Class;
			
		public function BoxstacleTop(X:int, Y:int) 
		{
			super(X-25, Y+4, PixelImage);
			//this.scale.x = 2;
			//this.scale.y = 2;
		}
	}
}