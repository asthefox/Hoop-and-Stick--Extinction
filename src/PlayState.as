﻿package
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
		
		override public function create():void
		{
			bg = new FlxSprite(0, 0, BG);
			bg.solid = false;
			
			ground = new Platform(0, 0, Ground);
			
			player = new Player();
			hoop = new Hoop();
			
			//cameraPoint = new FlxObject(player.x, FlxG.height/2, 1, 1);
			
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
			//cameraPoint.x = player1.x;
			//cameraPoint.y = FlxG.height / 2;
			//FlxG.follow(cameraPoint); 
			//FlxG.followAdjust(0.0, 0.0); 
			//FlxG.followBounds(level.boundsMinX, level.boundsMinY, level.boundsMaxX, level.boundsMaxY);
		}
	}
}