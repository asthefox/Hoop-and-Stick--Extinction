package  
{
	import org.flixel.*;
	
	public class ShootingButton extends FlxSprite
	{
		[Embed(source = "../content/paint_button.png")] protected var ButtonImage:Class;
		
		public var isOpen:Boolean = false;
		
		public function ShootingButton(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(ButtonImage, true, false, 72, 144);
			
			addAnimation("closed", [0]);
			addAnimation("open", [1]);
		}
		
		public override function update():void
		{
			if (isOpen) play("open");
			else play("closed");
			super.update();
		}
		
	}

}