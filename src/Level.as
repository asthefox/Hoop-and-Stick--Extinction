package  
{
	import org.flixel.*;
	
	public class Level
	{
		[Embed(source = "../content/sky.png")] protected var SkySprite:Class;
		[Embed(source = "../content/level1ground.png")] protected var Ground:Class;
		
		public static var LEVEL_HEIGHT : int = 1440;
		
		public var sky : FlxSprite;
		public var grounds : FlxGroup;
		
		public function Level() 
		{
			sky = new FlxSprite(0, 0);
			sky.loadGraphic(SkySprite, false, false, 640, 1440);
			sky.scrollFactor.x = 0;
			sky.solid = false;
			
			grounds = new FlxGroup();
			
			var ground0 : Platform = new Platform(0, 960, Ground);
			var ground1 : Platform = new Platform(640, 960, Ground);
			
			grounds.add(ground0);
			grounds.add(ground1);
			
			AddElements();
			
		}
		
		public function AddElements() : void
		{
			FlxG.state.add(sky);
			
			
			FlxG.state.add(grounds);
			

		}
		
		public function update() : void
		{
			//FlxG.log("" + grounds.members[0].facing);
		}
		
		
	}

}