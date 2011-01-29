package  
{
	import flash.display.*;
	import flash.geom.*;
	import flash.sampler.NewObjectSample;
	import org.flixel.*;
	
	/////
	//
	//	MobileSprite
	//	This class represents a sprite that moves on platforms.
	//	It automatically uses pixel-level hit detection when colliding with Platform objects, and comes to rest on them without jittering.
	//
	/////
	public class MobileSprite extends FlxSprite
	{
		
		protected static const GRAVITY_ACCELERATION:Number = 820;
		
		public function MobileSprite(X:Number=0,Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
		}
		
		public override function update():void
		{
			//Kills vertical speed when on floor, necessary to prevent jitteriness
			acceleration.y = onFloor ? 0 : GRAVITY_ACCELERATION;
			velocity.y = onFloor ? 0 : velocity.y;
			
			super.update();
		}
		
		
		public override function overlaps(Object:FlxObject):Boolean
		{
			if (Object is Platform && (Object as Platform).pixelPerfect)
			{
				return (FlxHitTest.complexHitTestObject(this, Object as FlxSprite));
			}
			
			return super.overlaps(Object);
		}
		
		public override function collide(Object:FlxObject=null):Boolean
		{
			//Is pixel-perfect collision required (e.g. are you colliding with a platform)?
			if (Object != null && Object is Platform && (Object as Platform).pixelPerfect)
			{
				//Yes
				var ObjectPP : Platform = Object as Platform;
				
				if(this is Player) DetermineSlope(ObjectPP);
				
				if (FlxHitTest.complexHitTestObject(this, ObjectPP))
				{
					onFloor = true;
					hitBottom(ObjectPP, 0);
					ObjectPP.hitTop(this, 0);
					
					//There's some jittery wonkiness with slopes - this smooths it out by adding a 2-pixel buffer zone					
					var hitArea : Rectangle = FlxHitTest.complexHitTestRectangle(this, ObjectPP);
					if (hitArea.y > 5)
					{
						y -= hitArea.height - 3;
					}
					return true;
				}
				
				return false;
			}
			
			return super.collide(Object);
		}
		
		public function DetermineSlope(platform:Platform) : void
		{
			var x1 : int = x;
			var x2 : int = x + width;
			var y1 : int = y + height;
			var dy1 : int = 0;
			var dy2 : int = 0;
			
			for (dy1 = -10; dy1 < 10; dy1++)
			{
				if (FlxHitTest.complexHitTestPoint(platform, x1, y1+dy1)) break;
			}
			
			for (dy2 = -10; dy2 < 10; dy2++)
			{
				if (FlxHitTest.complexHitTestPoint(platform, x2, y1+dy2)) break;
			}
			
			var slope:Number = (dy1 - dy2) / (x2 - x1);
			
			if(this is Player) FlxG.log("y1 = " + dy1 + "; y2= " + dy2 + "slope = " + slope);
			
		}
		
		//This is some stuff from Justin's code.  Not using it now , but keeping it in case it's useful for the hoop sliding later.
		public function slip(object:Platform):Boolean
		{
			/*
			var slipLeft = true;
			var slipRight = true;
			
				if(terrain.hitTestPoint(object.x+x+3,object.y+3,true))
				{
					slipRight = false;
				}
				if(terrain.hitTestPoint(object.x+x-3,object.y+3,true))
				{
					slipLeft = false;
				}
			
			var slideRate = .5
			if(slipRight)
			{
				object.xspeed+=slideRate
				return true
			}
			if(slipLeft)
			{
				object.xspeed-=slideRate
				return true
			}
			*/
			return false;
			
		}
		
		
		
	}

}