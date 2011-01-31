package  
{
	import org.flixel.*;
	public class PositiveText extends FlxText
	{
		public function PositiveText(_x:int, _y:int, message:String, _color:uint) 
		{
			//super(_x, _y, 340, message);
			super(FlxG.stage.width / 2, FlxG.stage.height / 4, 480, message);
			
			scrollFactor.x = scrollFactor.y = 0;
			color = _color;
			alignment = "center";
			size = 28;
			shadow = 0xFF000000;
			
			x -= width / 2;
			y -= height / 2;
			FlxG.state.add(this);
		}
		
		public override function update():void
		{
			alpha -= .004;
			y -= 0.4;
			if (alpha <= 0.03)
			{
				kill();
			}
			super.update();
		}
	}

}