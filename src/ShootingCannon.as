package  
{
	import org.flixel.*;
	public class ShootingCannon extends FlxSprite
	{
		[Embed(source = "../content/watercannonsheet.png")] protected var CannonImage:Class;
		//[Embed(source = "../content/PlayerAnim2.png")] protected var GuyImage:Class;
		//[Embed(source = "../content/Pixel.png")] protected var BulletImage:Class;
		
		public var isHappy : Boolean = false;
		public var isActive : Boolean = false;
		public var target : FlxSprite;
		
		public function ShootingCannon(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(CannonImage,true,false,60,60);
			//this.scale.x = 2;
			//this.scale.y = 2;
		}
		
	}

}