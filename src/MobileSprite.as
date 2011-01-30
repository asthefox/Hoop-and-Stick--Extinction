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
		
		protected static const GRAVITY_ACCELERATION:Number = 600;//820;

		protected var MIN_SLOPE : Number = 0.1;			//Minimum slope that causes rolling
		protected var ROLL_ACCELERATION : Number = 1;	//Rolling acceleration rate
		protected var MAX_ROLL_SPEED : Number = 100;	//Max rolling speed
		protected var FRICTION:Number = 20;
		
		protected var slope_acceleration : Number = 0;
		protected var force_acceleration : Number = 0;
		protected var ground_buffer : int = 5;
		protected var last_x : int = 0;
		protected var ROLL_BUFFER : Number = 1;
		
		public function MobileSprite(X:Number=0,Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			last_x = x;
		}
		
		public override function update():void
		{
			//Kills vertical speed when on floor, necessary to prevent jitteriness
			acceleration.y = GRAVITY_ACCELERATION;
			velocity.y = velocity.y;
			
			acceleration.x = force_acceleration;
			if (onFloor) {
				velocity.y = 0;
				acceleration.y = 0;
				
				acceleration.x += slope_acceleration;
				
				if (velocity.x > 0) {
					acceleration.x -= FRICTION;
				} else if (velocity.x < 0) {
					acceleration.x += FRICTION;
				}
			}
			
			last_x = x;
			
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
			//Are you colliding with a platform?
			if (Object != null && Object is Platform && (Object as Platform).pixelPerfect)
			{
				var ObjectPP : Platform = Object as Platform;
				
				//Are you in range to require pixel-perfect collision?
				if (x < ObjectPP.x + ObjectPP.width &&
					x + width > ObjectPP.x)
				{
					if(ROLL_ACCELERATION != 0) DetermineSlope(ObjectPP);
					
					if (this is Player && (this as Player).state == Player.STATE_JUMP && velocity.y < 0) return false; 
					
					if(FlxHitTest.complexHitTestPoint(ObjectPP, this.x+width/2, this.y+height-ground_buffer))
					{
						onFloor = true;
						hitBottom(ObjectPP, 0);
						ObjectPP.hitTop(this, 0);
						
						//var hitArea : Rectangle = FlxHitTest.complexHitTestRectangle(this, ObjectPP);
						var hitArea : Rectangle = FlxHitTest.complexHitTestSlice(ObjectPP, x+width/2, y+height);
						
						if (Math.abs(x - last_x) > ROLL_BUFFER && hitArea.y > ground_buffer)
						{
							y -= (hitArea.height - ground_buffer);
						}
						
						return true;
					}
					
					if (!FlxHitTest.complexHitTestPoint(ObjectPP, this.x + width / 2, this.y + height - ground_buffer + 10))
					{
						//FlxG.log("Fall!");
						Fall();
					}
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
			
			Slide(slope);
			
			//if(this is Player) FlxG.log("y1 = " + dy1 + "; y2= " + dy2 + "slope = " + slope);
		}
		
		public function Slide(slope:Number):void
		{
			if (Math.abs(slope) > MIN_SLOPE)
			{
				//FlxG.log("should roll");
				slope_acceleration = slope * -1 * ROLL_ACCELERATION;
			}
			else
			{
				//FlxG.log("should not roll");
				slope_acceleration = 0;
			}
		}
		
		public function Fall():void{}
	}
	


}