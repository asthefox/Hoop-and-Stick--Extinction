package  
{
	import org.flixel.*;
	public class Blimp extends FlxSprite
	{
		[Embed(source = "../content/blimpanim.png")] protected var BlimpImage:Class;
		public var flySpeed : Number = 0.4;
		
		public function Blimp(_X:int, _Y:int) 
		{
			super(_X, _Y);
			loadGraphic(BlimpImage, true, true, 400, 100);
			addAnimation("move", [0, 1, 2, 3], 5, true);
			scrollFactor.y = 1;
			scrollFactor.x = 0;
			solid = false;
			var randS : Number = Math.random() * 0.4 + 0.2;
			scale = new FlxPoint(randS, randS);
			play("move");
			
			flySpeed = flySpeed + (Math.random() * 0.4 - 0.2);
		}
		
		public override function update() : void
		{
			super.update();
			
			if (facing == LEFT)
			{
				x -= 0.7;
			}
			else if (facing == RIGHT)
			{
				x += 0.7;
			}
		}
		
	}

}