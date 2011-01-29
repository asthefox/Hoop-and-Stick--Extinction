package
{
	import flash.display.*;
	import flash.geom.*;
	import org.flixel.*;
	
	/////
	//
	//	Platform
	//	This class represents a platform that objects can move on.
	//	MobileSprites use pixel-level hit detection when colliding with Platform objects, so anything the player or hoop will walk over
	//	should extend this class.
	//
	//	You can set pixelPerfect to false to override pixel level hit detection.
	//
	/////
	public class Platform extends FlxSprite
	{
		public var pixelPerfect:Boolean = true;
		
		public function Platform(X:Number=0,Y:Number=0, SimpleGraphic:Class=null, _pixelPerfect:Boolean = true)
		{
			super(X, Y, SimpleGraphic);
			pixelPerfect = _pixelPerfect;
			fixed = true;
		}
	}

}