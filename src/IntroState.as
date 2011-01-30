package  
{
	import org.flixel.*;
	public class IntroState extends FlxState
	{
		[Embed(source = "../content/introscreen.png")] protected var ExtraExtra:Class;
		[Embed(source = "../content/blimpanim.png")] protected var BlimpPic:Class;
		[Embed(source = "../content/sky.png")] protected var SkySprite:Class;
		[Embed(source = "../content/HugeBuildingsLow.png")] protected var BuildingHugeLow:Class;
		
		
		public var fires : FlxGroup = new FlxGroup();
		
		public var blimps : FlxGroup = new FlxGroup();
		public var sky : FlxSprite = new FlxSprite(0, 0, SkySprite);
		public var buildingsLow : FlxSprite = new FlxSprite( -320, 150, BuildingHugeLow);
		
		public var extraExtra : FlxSprite = new FlxSprite(0, 0, ExtraExtra);
		public var camState : int = 0;
		
		public var endScene : Boolean = false;
		
		public var targetX:int;
		public var targetY:int;
		
		public var targetScaleX:Number;				
		public var targetScaleY:Number;
		
		public var scaleEasing:Number;
		public var posEasing:Number;


		public function IntroState() 
		{	
			add(sky);
			
			//city----------------------------------------------
			add(buildingsLow);
			buildingsLow.scale.x = 0.5;
			buildingsLow.scale.y = 0.5;
			
			//fire-----------------------------------------------
			var fire1:Fire = new Fire(400, 600);
			fire1.scale.x = 5;
			fire1.scale.y = 5;
			fires.add(fire1);
			
			var fire5:Fire = new Fire(100, 400);
			fire5.scale.x = 5;
			fire5.scale.y = 5;
			fires.add(fire5);
			
			var fire6:Fire = new Fire(300, 500);
			fire6.scale.x = 4;
			fire6.scale.y = 4;
			fires.add(fire6);
			
			var fire2:Fire = new Fire(200, 650);
			fire2.scale.x = 3;
			fire2.scale.y = 3;
			fires.add(fire2);
			
			var fire3:Fire = new Fire(600, 400);
			fire3.scale.x = 5;
			fire3.scale.y = 5;
			fires.add(fire3);
			
			var fire4:Fire = new Fire(-100, 300);
			fire4.scale.x = 6;
			fire4.scale.y = 6;
			fires.add(fire4);
			
			add(fires);
			
			//blimps------------------------------------------------
			var blimp01:Blimp = new Blimp(-200, 180);
			blimp01.scale.x = .4;
			blimp01.scale.y = .4;
			blimp01.velocity.x = 7;
			blimps.add(blimp01);
			
			var blimp02:Blimp = new Blimp(-400, 220);
			blimp02.scale.x = .5;
			blimp02.scale.y = .5;
			blimp02.velocity.x = 17;
			blimps.add(blimp02);
			
			var blimp03:Blimp = new Blimp(-800, 150);
			blimp03.scale.x = 1;
			blimp03.scale.y = 1;
			blimp03.velocity.x = 50;
			blimps.add(blimp03);
			
			var blimp04:Blimp = new Blimp(-1200, 50);
			blimp04.scale.x = 2;
			blimp04.scale.y = 2;
			blimp04.velocity.x = 100;
			blimps.add(blimp04);
			
			add(blimps);
			
			//newspaper-----------------------------------------------
			extraExtra.scale.x *= 5;
			extraExtra.scale.y *= 5;
			extraExtra.x += 1000;
			extraExtra.y += 300;
			
			add(extraExtra);
			
			
			/*
			var titleText : FlxText = new FlxText(FlxG.width / 2, 100, 600, "Intro Cutscene");
			titleText.size = 16;
			titleText.alignment = "center";
			titleText.x -= titleText.width / 2;
			add(titleText);
			var titleText2 : FlxText = new FlxText(FlxG.width / 2, 200, 600, "Wow. Hoop & Stick. What are the Odds?");
			titleText2.size = 16;
			titleText2.alignment = "center";
			titleText2.x -= titleText2.width / 2;
			add(titleText2);
			var promptText : FlxText = new FlxText(FlxG.width / 2, 300, 600, "Press Enter to Get on with It");
			promptText.size = 16;
			promptText.alignment = "center";
			promptText.x -= promptText.width / 2;
			add(promptText);
			*/
		}
		
		public override function create():void
		{
			FlxG.flash.start(0xFF000000);
		}
		
		public override function update():void
		{
			newsflash();
			
			if (camState == 3)
			{
				moveBlimps();
				
				for (var i:int = 0; i < fires.members.length; i++)
				{
					if (fires.members[i].alpha == 0)
					{
						fires.members[i].y += 250;
					}
					
					fires.members[i].update();
					fires.members[i].alpha += 0.001;
					fires.members[i].y -= 0.4;
					
					if (fires.members[i].alpha >= 0.6 && !endScene)
					{
						FlxG.fade.start(0xff000000, 3, MyFadeComplete, true);
						endScene = true;
					}
				}
			}
			
			CheckInput();
		}
		
		private function moveBlimps():void
		{
			for (var i:int = 0; i < blimps.members.length; i++)
			{
				blimps.members[i].update();
			}
		}
		
		private function newsflash():void 
		{
			if (camState == 0)
			{
				targetX = -60;
				targetY = 50;
				
				targetScaleX = 1.4;
				targetScaleY = 1.4;
				
				scaleEasing = 0.01;
				posEasing = 0.01;
				
				if (extraExtra.x < -30)
				{
					camState++;
				}
			}
			else if (camState >= 1)
			{
				targetScaleX = 2.2;
				targetScaleY = 2.2;
				targetX = -190;
				targetY = -287;
				
				if (Math.abs(extraExtra.x - targetX) < 45)
				{
					camState = 3;
					extraExtra.alpha-=0.003;
				}
			}
			
			extraExtra.scale.x -= (extraExtra.scale.x - targetScaleX) * scaleEasing;
			extraExtra.scale.y -= (extraExtra.scale.y - targetScaleY) * scaleEasing;
			
			extraExtra.x -= (extraExtra.x - targetX) * posEasing;
			extraExtra.y -= (extraExtra.y - targetY) * posEasing;
		}
		
		private function MyFadeComplete() : void
		{
			HoopAndStick.GetNextState();
		}
		
		private function CheckInput() : void
		{	
			if (FlxG.keys.justPressed("ENTER"))
			{
				HoopAndStick.GetNextState();
			}
		}
		
	}

}