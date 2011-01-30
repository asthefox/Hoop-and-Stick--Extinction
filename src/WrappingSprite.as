package  
{
	import org.flixel.*;
	
	public class WrappingSprite extends FlxGroup
	{
		private var spriteWidth : int;
		private var numCopies : int;
		private var moveSpeed : int;
		private var startingX : int;
		
		public function WrappingSprite(_X:int, _Y:int, _W:int, _H:int, _Image:Class, _Copies:int = 2, Xscrolling:int = 1, Yscrolling:int = 1, _MoveSpeed:int = 0) 
		{
			startingX = _X;
			spriteWidth = _W;
			numCopies = _Copies;
			moveSpeed = _MoveSpeed;
			
			for (var i:int = 0; i < numCopies; i++)
			{
				var theSprite : FlxSprite = new FlxSprite(_X + (_W * i), _Y);
				theSprite.loadGraphic(_Image, false, false, _W, _H);
				theSprite.scrollFactor.x = Xscrolling;
				theSprite.scrollFactor.y = Yscrolling;
				add(theSprite);
			}
			
			
		}
		
		public override function update() : void
		{
			super.update();
			
			for (var i:int = 0; i < members.length; i++)
			{
				members[i].x -= moveSpeed;
				
				if (members[i].x < startingX-spriteWidth)
				{
					
					members[i].x += spriteWidth * numCopies;
				}
			}
		}
	}

}