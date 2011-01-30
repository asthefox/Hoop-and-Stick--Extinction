package  
{
	import org.flixel.*;
	
	public class Level
	{
		[Embed(source = "../content/sky.png")] protected var SkySprite:Class;
		[Embed(source = "../content/level1ground.png")] protected var Ground:Class;
		[Embed(source = "../content/ground1-1.png")] protected var Ground1:Class;
		[Embed(source = "../content/ground1-2.png")] protected var Ground2:Class;
		[Embed(source = "../content/ground1-3.png")] protected var Ground3:Class;
		[Embed(source = "../content/ground1-4.png")] protected var Ground4:Class;
		[Embed(source = "../content/ground1-5.png")] protected var Ground5:Class;
		[Embed(source = "../content/ground1-6.png")] protected var Ground6:Class;
		[Embed(source = "../content/ground1-7.png")] protected var Ground7:Class;
		[Embed(source = "../content/ground1-8.png")] protected var Ground8:Class;
		[Embed(source = "../content/ground1-9.png")] protected var Ground9:Class;
		[Embed(source = "../content/ground1-10.png")] protected var Ground10:Class;
		
		//poison gas
		[Embed(source = "../content/gratesheet.png")] protected var Poison:Class;
		[Embed(source = "../content/spikes.png")] protected var Spikes:Class;
		
		public static var LEVEL_HEIGHT : int = 1440;
		
		public var sky : FlxSprite;
		public var grounds : FlxGroup;
		public var poisons: FlxGroup;
		public var spikes: FlxGroup;
		
		public function Level() 
		{
			sky = new FlxSprite(0, 0);
			sky.loadGraphic(SkySprite, false, false, 640, 1440);
			sky.scrollFactor.x = 0;
			sky.solid = false;
			
			spikes = new FlxGroup();
			var spikes1: FlxSprite = new FlxSprite(0 + 640 *0 + 300, 1198, Spikes);
			spikes.add(spikes1);
			
			poisons = new FlxGroup();
			
			var poisons1: FlxSprite = new FlxSprite(0 + 640 * 0 + 848, 1198, Poison);
			poisons.add(spikes1);
			var poisons2: FlxSprite= new FlxSprite(0 + 640 * 1 + 50, 1198,Poison);
			poisons.add(poisons2);
			var poisons3: FlxSprite= new FlxSprite(0 + 640 * 2 + 50, 1198,Poison);
			poisons.add(poisons3);
			var poisons4: FlxSprite = new FlxSprite(0 + 640 * 0 + 50, 1198, Poison);
			poisons.add(poisons4);
			var poisons5: FlxSprite = new FlxSprite(0 + 640 * 0 + 50, 1198, Poison);
			poisons.add(poisons5);
			var poisons6: FlxSprite = new FlxSprite(0 + 640 * 0 + 50, 1198, Poison);
			poisons.add(poisons6);
			var poisons7: FlxSprite = new FlxSprite(0 + 640 * 0 + 50, 1198, Poison);
			poisons.add(poisons7);
			
			
			grounds = new FlxGroup();
			
			var ground1 : Platform = new Platform(0 + 640*0, 1198, Ground1);
			grounds.add(ground1);
			var ground2 : Platform = new Platform(0 + 640*1, 1198, Ground2);
			grounds.add(ground2);
			var ground3 : Platform = new Platform(0 + 640*2, 1198, Ground3);
			grounds.add(ground3);
			var ground4 : Platform = new Platform(0 + 640*3, 1198, Ground4);
			grounds.add(ground4);
			var ground5 : Platform = new Platform(0 + 640*4, 1198, Ground5);
			grounds.add(ground5);
			var ground6 : Platform = new Platform(0 + 640*5, 1198, Ground6);
			grounds.add(ground6);
			var ground7 : Platform = new Platform(0 + 640*6, 1198, Ground7);
			grounds.add(ground7);
			var ground8 : Platform = new Platform(0 + 640*7, 1198, Ground8);
			grounds.add(ground8);
			var ground9 : Platform = new Platform(0 + 640*8, 1198, Ground9);
			grounds.add(ground9);
			var ground10 : Platform = new Platform(0 + 640*9, 1198, Ground10);
			grounds.add(ground10);
			
			AddElements();
			
		}
		
		public function AddElements() : void
		{
			FlxG.state.add(sky);
			FlxG.state.add(spikes);
			FlxG.state.add(poisons);
			FlxG.state.add(grounds);
			

		}
		
		public function update() : void
		{
			//FlxG.log("" + grounds.members[0].facing);
		}
		
		
	}

}