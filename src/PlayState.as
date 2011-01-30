﻿package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{
		//Embedding Flixel images into classes
		
		public var level1 : Level;
		
		public var player : Player;
		public var hoop : Hoop;
		protected var cameraPoint : FlxObject = null;
		protected const CAMERA_LEAD_X : int = 30;
		protected const CAMERA_LEAD_Y : int = 30;
		
		override public function create():void
		{	
			level1 = new Level();
			
			player = new Player(100, 960);
			hoop = new Hoop(100, 960);
			
			//World bounds are set in UpdateCamera now
			//TODO: Change this once we finalize the level design
			//FlxU.setWorldBounds(0, 0, 6400, 960);
			cameraPoint = new FlxObject(player.x, FlxG.height/2, 1, 1);
			
			
			add(player);
			add(hoop);			
		}
		
		public override function update():void
		{	
			
			CheckBowlingCollision();
			CheckGroundCollision();
			CheckStickHit();
			CheckPoisonsCollision();
			CheckSpikesCollision();
			UpdateShootingSituation();
			UpdateCamera();
			
			CheckInput();
			
			super.update();
		}
		
		protected function CheckBowlingCollision() : void
		{
			if (level1.bowlingPins.exists)
			{
				//player-hoop-pin barrier
				if (player.x > level1.bowlingPins.x)
				{
					player.x = level1.bowlingPins.x;
				}
				if (hoop.x > level1.bowlingPins.x)
				{
					hoop.x = level1.bowlingPins.x;
				}
				
				if (FlxU.collide(level1.bowlingPins, level1.bowlingball))
				{
					level1.bowlingPins.strike();
				}
				if (FlxU.solveXCollision(hoop,level1.bowlingball))
				{
					var pText : PositiveText = new PositiveText(player.x, level1.bowlingball.y - 40, "GAME STARTED: BOWLING!\nONE OF THREE GAMES REVIVED", 0xffffff);
					level1.bowlingball.hit = true;
				}
			}
			else
			{
				if (level1.bowlingball.exists)
				{
					level1.bowlingball.kill();
				}
			}
		}
		
		protected function UpdateShootingSituation() : void
		{
			if (level1.shootingSituation.obstacle.exists)
			{
				level1.shootingSituation.activated = (player.x > level1.shootingSituation.x);
				
				//player-hoop-fire barrier
				if (player.x > level1.shootingSituation.obstacle.x - 100)
				{
					player.x = level1.shootingSituation.obstacle.x - 100;
				}
				if (hoop.x > level1.shootingSituation.obstacle.x - 120)
				{
					hoop.x = level1.shootingSituation.obstacle.x - 120;
				}
			}
			else
			{
				level1.shootingSituation.activated = false;
			}
		}

		
		
		protected function CheckPoisonsCollision() : void
		{
			//Check for poison collision with Player
			for (var i : int = 0; i < level1.poisons.members.length; i++)
			{
				level1.poisons.members[i].play("PoisonAnimation");
				if (player.overlaps(level1.poisons.members[i]) == true) {
					//slow down player
					player.velocity.x = -1000;
				}
			}
		}
		
		protected function CheckSpikesCollision() : void
		{
			//Check for poison collision
			for (var i : int = 0; i < level1.spikes.members.length; i++)
			{
				if (hoop.overlaps(level1.spikes.members[i]) == true) {
					if (hoop.velocity.x > 0) {
						hoop.velocity.x -= 100;
						hoop.flicker(1.5); 
					}
					else {
						//player.velocity.x += 40;
						hoop.velocity.x += 100;
						hoop.flicker(1.5); 
					}
				}
			}
		}
		
		protected function CheckGroundCollision() : void
		{
			var playerOnPlatform : Boolean = false;
			var hoopOnPlatform : Boolean = false;
			player.supported = false;
			
			
			//Check for ground collision - player
			for (var i : int = 0; i < level1.grounds.members.length; i++)
			{
				if (player.collide(level1.grounds.members[i]))
				{
					playerOnPlatform = true;
					break;
				}
			}
			
			//Check for ground collision - hoop
			for (i = 0; i < level1.grounds.members.length; i++)
			{
				if (hoop.collide(level1.grounds.members[i]))
				{
					hoopOnPlatform = true;
					break;
				}
			}
			
			//Check for ground collision - bowling ball
			if (level1.bowlingball != null && level1.bowlingball.exists)
			{
				for (i = 0; i < level1.grounds.members.length; i++)
				{
					if (level1.bowlingball.collide(level1.grounds.members[i]))
					{
						break;
					}
				}
			}
			
			if (!playerOnPlatform)
			{
				for (i = 0; i < level1.boxstacles.members.length; i++)
				{
					if (player.collide(level1.boxstacleTops.members[i]))
					{
						playerOnPlatform = true;
						break;
					}
				}
			}
			
			if (!hoopOnPlatform)
			{
				for (i = 0; i < level1.boxstacles.members.length; i++)
				{
					if (hoop.collide(level1.boxstacleTops.members[i]))
					{
						hoopOnPlatform = true;
						break;
					}
				}
			}
			
			
			for (i = 0; i < level1.boxstacles.members.length; i++)	
			{
				FlxU.solveXCollision(hoop,level1.boxstacles.members[i]);
				FlxU.solveYCollision(hoop, level1.boxstacles.members[i]);
				
				FlxU.solveXCollision(player,level1.boxstacles.members[i]);
				FlxU.solveYCollision(player,level1.boxstacles.members[i]);
			}
			
			if (!playerOnPlatform && !player.supported) 
			{
				player.Fall();
			}
			
			if (!hoopOnPlatform && !hoop.supported) 
			{
				hoop.Fall();
			}
		}
		
		protected function CheckStickHit() : void {
			//Check for hoop and stick collision
			//Is player swinging?
			if (player.state == Player.STATE_SWING && hoop.state != Hoop.STATE_LOSE)
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
			}
			else if (player.facing == FlxSprite.RIGHT)
			{
				cameraPoint.x += CAMERA_LEAD_X;
			}
			
			
			FlxG.follow(player, 100);
			//FlxG.followAdjust(0.5, 0); 
			FlxG.followBounds(0, 0, 6400, 1440, true); //also sets world bounds
		}
		
		public function CheckInput() : void
		{
			if (FlxG.keys.justPressed("ENTER"))
			{
				HoopAndStick.GetNextState();
			}
		}
	}
}