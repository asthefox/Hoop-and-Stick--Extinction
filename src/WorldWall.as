package  
{
	import org.flixel.*;
	
	public class WorldWall extends FlxSprite
	{
		
		public function WorldWall(_X:int, _Y:int) 
		{
			super(_X, _Y);
			
			createGraphic(10, 1400);
			solid = true;
			fixed = true;
			visible = false;
		}
		
	}

}