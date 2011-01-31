package  
{
	import org.flixel.*;
	public class PositiveText extends FlxText
	{
		public function PositiveText(_x:int, _y:int, message:String, _color:uint) 
		{
			super(_x, _y, 340, message);
			color = _color;
			alignment = "center";
			size = 20;
			shadow = 0xFF000000;
			x -= width / 2;
			y -= height / 2;
			FlxG.state.add(this);
		}
		
		public override function update():void
		{
			alpha -= .004;
			y -= 0.5;
			if (alpha <= 0.03)
			{
				kill();
			}
			super.update();
		}
	}

}