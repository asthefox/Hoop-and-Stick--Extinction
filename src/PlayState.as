package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{
		//Embedding Flixel images into classes
		[Embed(source = "../content/level1ground.png")] 	protected var Ground:Class;
		[Embed(source = "../content/level1bg.png")] protected var BG:Class;
		
		protected var bg : FlxSprite;
		protected var ground : FlxSprite;
		protected var player : FlxSprite;
		protected var hoop : FlxSprite;
		protected var cameraPoint : FlxObject = null;
		
		override public function create():void
		{
			bg = new FlxSprite(0, 0, BG);
			bg.solid = false;
			
			ground = new FlxSpritePP(0, 0, true, Ground);
			
			player = new Player();
			
			//cameraPoint = new FlxObject(player.x, FlxG.height/2, 1, 1);
			
			add(bg);
			add(ground);
			add(player);
		}
		
		public override function update():void
		{	
			if (ground.collide(player))
			{
				player.hitBottom(ground, -10);
				ground.hitTop(player, 0);
			}
			
			//cameraPoint.x = player1.x;
			//cameraPoint.y = FlxG.height / 2;
			//FlxG.follow(cameraPoint); 
			//FlxG.followAdjust(0.0, 0.0); 
			//FlxG.followBounds(level.boundsMinX, level.boundsMinY, level.boundsMaxX, level.boundsMaxY);	
			
			super.update();
		}
	}
}