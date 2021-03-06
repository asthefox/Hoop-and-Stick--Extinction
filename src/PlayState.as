﻿package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{
		//Embedding Flixel images into classes
		
		public var level1 : Level;
		
		public var player : Player;
		public var hoop : Hoop;
		public static var win: Boolean = false;
		public static var playerhoopoverlap: Boolean; 
		public var reachedBoss : Boolean = false;
		
		public var wallL : WorldWall;
		public var wallR : WorldWall;
		
		protected var cameraPoint : FlxObject = null;
		protected const CAMERA_LEAD_X : int = 30;
		protected const CAMERA_LEAD_Y : int = 30;
		
		protected var gameOver:Boolean = false;

		public var speedTrap : Boolean = false;
		
		override public function create():void
		{	
			wallL = new WorldWall(0, 0);
			add(wallL);
			wallR = new WorldWall(6390, 0);
			add(wallR);
			
			level1 = new Level();
			
			//FOR BOSS TESTING
			//player = new Player(5100, 1000);
			//hoop = new Hoop(5100, 1000);
			
			player = new Player(100, 1200);
			hoop = new Hoop(100, 1200);
			
			
			//World bounds are set in UpdateCamera now
			//FlxU.setWorldBounds(0, 0, 6400, 960);
			cameraPoint = new FlxObject(player.x, FlxG.height/2, 1, 1);
			
			gameOver = false;
			
			add(player);
			add(hoop);		
			
			FlxG.flash.start(0xFF000000);
		}
		
		public override function update():void
		{	
			//Check for hoop and stick collision
			if (player.overlaps(hoop)== true) {
				playerhoopoverlap = true;
			}
			else if(player.overlaps(hoop)== false){
					playerhoopoverlap = false;
			}
			
			CheckBowlingCollision();
			CheckGroundCollision();
			CheckStickHit();
			CheckPoisonsCollision();
			UpdateShootingSituation();
			CheckBossCollision();
			
			//CheckSpikesCollision();
			
			UpdateCamera();
			
			CheckInput();
			
			CheckForEndState();
			
			wallL.collide(player);
			wallL.collide(hoop);
			wallR.collide(player);
			wallR.collide(hoop);
			
			if (!reachedBoss && player.x > 5300)
			{
				reachedBoss = true;
				level1.SpawnBoss();
				var warningText : PositiveText = new PositiveText(player.x, 1150, "WARNING: \nAnti-Game Enforcement Approaching", 0xffffcccc);
				warningText.size = 30;
			}
			
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
					level1.bowlingball.hit = true;
				}
				
				//Check for ground collision - bowling ball
				for (var i : int = 0; i < level1.grounds.members.length; i++)
				{
					/*
					if (level1.bowlingball.collide(level1.boxstacleTops.members[15]))
					{
						break;
					}
					*/
					if (level1.bowlingball.collide(level1.grounds.members[i]))
					{
						break;
					}
				}
			}
			else
			{
				if (level1.bowlingball.exists)
				{
					var pText : PositiveText = new PositiveText(player.x, level1.bowlingPins.y, "GAME STARTED: BOWLING!\nONE OF THREE GAMES REVIVED", 0xffffff);
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
				
				if (player.overlaps(level1.poisons.members[i]) == true)
				//slow down player
				{
					if (!speedTrap)
					{
						player.velocity.x *= 0.5;
						speedTrap = true;
					}
				}
				else
				{
					speedTrap = false;
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
		
		
		public function CheckForEndState() : void
		{
			if (hoop.state == 4 && !gameOver) {
				FlxG.log("Bang!");
				gameOver = true;
				win = false;
				FlxG.fade.start(0xff000000, 8, MyFadeComplete, true);
			}
			if (reachedBoss) 
			{
				if (level1.boss.bossHealth < 1 && !gameOver) {
					gameOver = true;
					win = true;
					FlxG.fade.start(0xff000000, 8, MyFadeComplete, true);
				}
			}
		}
		public function MyFadeComplete() : void {
			    //FlxG.flash.start(0xff000000, 0.1);
				HoopAndStick.GetNextState();
		}

		public function CheckInput() : void
		{
		}
		
		public function CheckBossCollision() : void
		{
			if (reachedBoss)
			{
				if (hoop.collide(level1.boss.weakPoint))
				{
					level1.boss.TakeDamage();
				}
				
				for (var k : int = 0; k < level1.boss.hoopArray.length; k++)
				{
					for  (var i : int = 0; i < level1.grounds.members.length; i++)
					{
						level1.boss.hoopArray[k].collide(level1.grounds.members[i]);
					}
					
					
					
					//check if player hits FakeHoops
					//Is player swinging?
					if (player.state == Player.STATE_SWING)
					{
						//Has player hit hoop for the first time this swing?
						if (player.stickDir != Player.NONE && FlxHitTest.complexHitTestObject(player, level1.boss.hoopArray[k]))
						{	
							player.stickDir = Player.NONE;
							level1.boss.hoopArray[k].KillSoon();
						}
					}
					
					
				}
			}
			
			
			
			
			
		}
		
		
		
	}
}