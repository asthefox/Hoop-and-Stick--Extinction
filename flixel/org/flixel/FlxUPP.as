/*
 * This code is in public domain. 
 */
package org.flixel
{
	import flash.geom.*;
	import org.flixel.*;
	
	public class FlxUPP
	{
		/**
		 * Checks pixel perfect overlaps between FlxSpritePP's and FlxGroup's. 
		 * Note that this function ignores anything except FlxGroup and FlxSpritePP.
		 * 
		 * @param	Object1		The first FlxSpritePP or group you want to check. 
		 * @param	Object2		The second FlxSpritePP or group you want to check.  Can be the same as the first.
		 * @param	Callback	e.g. <code>myOverlapFunction(Object1:FlxObject, Object2:FlxObject, Point:FlxPoint);  If no function is provided, overlapPP will call <code>kill()</code> on both objects.
		 */
		public static function overlapPP(obj1:FlxObject, obj2:FlxObject, callback:Function = null):Boolean
		{
			if (!obj1 || ! obj1.exists || !obj2 || !obj2.exists)
				return false;
			
			var retVal:Boolean = false;
			
			if (obj1 is FlxGroup) 
			{
				for each(var subObj1:FlxObject in (obj1 as FlxGroup).members)
					retVal = retVal || overlapPP(subObj1, obj2, callback);
				return retVal;
			}
			else if (obj1 is FlxSpritePP)
			{
				if (!obj1.solid)
					return false;
				
				(obj1 as FlxSpritePP).preparePP();
				
				if (obj2 is FlxGroup)
				{
					for each(var subObj2:FlxObject in (obj2 as FlxGroup).members)
						retVal = retVal || overlapPP(obj1, subObj2, callback)
					return retVal;
				}
				else if(obj2 is FlxSpritePP)
				{
					if (!obj2.solid)
						return false;
					
					(obj2 as FlxSpritePP).preparePP();
					
					var rect:Rectangle = (obj1 as FlxSpritePP).overlapsPP(obj2 as FlxSpritePP)
					if (!rect)
						return false;
					
					if (callback != null)
					{
						var p:FlxPoint = new FlxPoint(rect.x + rect.width / 2, rect.y + rect.height / 2)
						callback(obj1, obj2, p);
					}
					else
					{
						obj1.kill();
						obj2.kill();
					}
						
					return true;
				}
			}
			
			return false;
		}
	}

}