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
		protected var player : Player;
		protected var hoop : Hoop;
		protected var cameraPoint : FlxObject = null;
		protected const CAMERA_LEAD_X : int = 30;
		protected const CAMERA_LEAD_Y : int = 30;
		
		override public function create():void
		{	
			bg = new FlxSprite(0, 0, BG);
			bg.solid = false;
			
			ground = new Platform(0, 0, Ground);
			
			player = new Player();
			hoop = new Hoop();
			
			//Set World bounds. NOTE: this is done in UpdateCamera now
			//TODO: Change this once we finalize the level design
			//FlxU.setWorldBounds(0, 0, 6400, 960);
			cameraPoint = new FlxObject(player.x, FlxG.height/2, 1, 1);
			
			add(bg);
			add(ground);
			add(player);
			add(hoop);
			
			
		}
		
		public override function update():void
		{	
			CheckGroundCollision();
			CheckStickHit();
			UpdateCamera();
			
			super.update();
		}
		
		protected function CheckGroundCollision() : void
		{
			//Check for ground collision
			player.collide(ground);
			hoop.collide(ground);
		}
		
		protected function CheckStickHit() : void {
			//Check for hoop and stick collision
			//Is player swinging?
			if (player.state == Player.STATE_SWING)
			{
				//Has player hit hoop for the first time this swing?
				if (player.stickDir != Player.NONE && FlxHitTest.complexHitTestObject(player, hoop))
				{
					switch(player.stickDir)
					{
						case FlxSprite.DOWN:
							FlxG.log("hit down");
							hoop.velocity.y *= Player.VERTICAL_HIT_DAMPEN;
						break;
						case FlxSprite.UP:
							FlxG.log("hit up");
							hoop.velocity.y = -1 * Player.VERTICAL_HIT_FORCE;
						break;
						case FlxSprite.LEFT:
							FlxG.log("hit left");
							hoop.velocity.x -= Player.HORIZONTAL_HIT_FORCE;
						break;
						case FlxSprite.RIGHT:
							FlxG.log("hit right");
							hoop.velocity.x += Player.HORIZONTAL_HIT_FORCE;
						break;
					}
					
					player.stickDir = Player.NONE;
					hoop.hit = true;
				}
			}
		}
		
		protected function UpdateCamera():void
		{
			cameraPoint.x = player.x;
			cameraPoint.y = player.y - 50; //FlxG.height / 2;
			
			if (player.facing == FlxSprite.LEFT)
			{
				cameraPoint.x -= CAMERA_LEAD_X;
				FlxG.log("facing left");
			}
			else if (player.facing == FlxSprite.RIGHT)
			{
				cameraPoint.x += CAMERA_LEAD_X;
				FlxG.log("facing right");
			}
			
			
			FlxG.follow(player, 100);
			//FlxG.followAdjust(0.5, 0); 
			//FlxG.followBounds(0, 0, 6400, 960, true); //also sets world bounds
		}
	}
}