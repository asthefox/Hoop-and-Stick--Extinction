package  
{
	import org.flixel.*;
	public class ShootingObstacle extends FlxSprite
	{
		[Embed(source = "../content/paint_door.png")] protected var ObstacleImage:Class;
		
		public function ShootingObstacle(X:int, Y:int) 
		{
			super(X, Y, ObstacleImage);
		}
		
	}

}