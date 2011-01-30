package  
{
	import org.flixel.*;
	public class ShootingGuy extends FlxSprite
	{
		//[Embed(source = "../content/watercannonsheet.png")] protected var CannonImage:Class;
		[Embed(source = "../content/CannonAdmin.png")] protected var GuyImage:Class;
		//[Embed(source = "../content/Pixel.png")] protected var BulletImage:Class;
		
		public var isHappy : Boolean = false;
		public var target : FlxSprite;
		
		
		public function ShootingGuy(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(GuyImage, true, false, 50, 100);
			
			addAnimation("happy", [1]);
			addAnimation("unhappy", [0]);
		}
		
		public override function update() : void
		{
			if (isHappy)
			{
				play("happy");
			}
			else
			{
				play("unhappy");
			}
			
			super.update();
		}
		
	}

}