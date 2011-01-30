package  
{
	import org.flixel.*;
	public class ShootingTarget extends FlxSprite
	{
		[Embed(source = "../content/paint_target.png")] protected var TargetImage:Class;
		
		public function ShootingTarget(X:int, Y:int) 
		{
			super(X, Y, TargetImage);
		}
		
	}

}