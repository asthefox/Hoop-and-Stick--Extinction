package  
{
	import org.flixel.*;
	public class Fire extends FlxSprite
	{
		[Embed(source = "../content/fireSheet.png")] protected var FireImage:Class;
		
		public function Fire(_X:int, _Y:int)
		{
			super(_X, _Y);
			loadGraphic(FireImage, true, true, 60, 120);
			addAnimation("burn", [0, 1, 2, 3], 5, true);
			alpha = 0;
			play("burn");
		}
		
		public override function update() : void
		{
			super.update();
		}
	}
}