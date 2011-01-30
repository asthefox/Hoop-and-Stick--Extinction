package  
{
	import org.flixel.*;
	
	public class Level
	{
		[Embed(source = "../content/sky.png")] protected var SkySprite:Class;
		[Embed(source = "../content/level1ground.png")] protected var Ground:Class;
		
		public static var LEVEL_HEIGHT : int = 1440;
		
		public var sky : FlxSprite;
		public var ground : Platform;
		
		public function Level() 
		{
			sky = new FlxSprite(0, 0);
			sky.loadGraphic(SkySprite, false, false, 640, 1440);
			sky.solid = false;
			
			ground = new Platform(0, 960, Ground);
			
			
			
			
			
			AddElements();
			
			
			
			
			
			
			
		}
		
		public function AddElements() : void
		{
			FlxG.state.add(sky);
			FlxG.state.add(ground);

		}
		
		
	}

}