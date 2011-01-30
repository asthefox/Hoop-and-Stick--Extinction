package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{
		//Embedding Flixel images into classes
		
		protected var level1 : Level;
		
		protected var player : Player;
		protected var hoop : Hoop;
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
			//CheckBowlingCollision();
			CheckGroundCollision();
			CheckStickHit();
			CheckPoisonsCollision();
			CheckSpikesCollision();
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
			
			//Check for ground collision
			for (var i : int = 0; i < level1.grounds.members.length; i++)
			{
				if(player.collide(level1.grounds.members[i])) playerOnPlatform = true;
				hoop.collide(level1.grounds.members[i]);
				level1.bowlingball.collide(level1.grounds.members[i]);
			}
			
			for (i = 0; i < level1.boxstacles.members.length; i++)
			{
				if(player.collide(level1.boxstacleTops.members[i])) playerOnPlatform = true;
				hoop.collide(level1.boxstacleTops.members[i]);

				FlxU.solveXCollision(hoop,level1.boxstacles.members[i]);
				FlxU.solveYCollision(hoop, level1.boxstacles.members[i]);
				
				FlxU.solveXCollision(player,level1.boxstacles.members[i]);
				FlxU.solveYCollision(player,level1.boxstacles.members[i]);
			}
			
			if (!playerOnPlatform)
			{
			//	if (!FlxHitTest.complexHitTestPoint(ObjectPP, this.x + width / 2, this.y + height - ground_buffer + 10))
			//{
				//FlxG.log("Fall!");
				player.Fall();
			//}
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