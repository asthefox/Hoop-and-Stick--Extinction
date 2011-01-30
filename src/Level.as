﻿package  
{
	import org.flixel.*;
	
	public class Level
	{
		[Embed(source = "../content/sky.png")] protected var SkySprite:Class;
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
		
		[Embed(source = "../content/HugeBuildingsLow.png")] protected var BuildingHugeLow:Class;
		[Embed(source = "../content/HugeBuildingsHigh.png")] protected var BuildingHugeHigh:Class;
		[Embed(source = "../content/SmallBuilding1.png")] protected var BuildingSmall1:Class;
		[Embed(source = "../content/SmallBuilding2.png")] protected var BuildingSmall2:Class;
		[Embed(source = "../content/SmallBuilding3.png")] protected var BuildingSmall3:Class;
		[Embed(source = "../content/SmallBuilding4.png")] protected var BuildingSmall4:Class;
		[Embed(source = "../content/SmallBuilding5.png")] protected var BuildingSmall5:Class;
		[Embed(source = "../content/SmallBuilding6.png")] protected var BuildingSmall6:Class;
		[Embed(source = "../content/SmallBuilding7.png")] protected var BuildingSmall7:Class;
		
		//poison gas
		[Embed(source = "../content/gratesheet.png")] protected var Poison:Class;
		[Embed(source = "../content/spikes.png")] protected var Spikes:Class;
		[Embed(source = "../content/hoop.png")] protected var TestImage:Class;
		
		public static var LEVEL_HEIGHT : int = 1440;
		public const NUM_BUILDING_LOOPS : int = 4;
		public const LITTLE_BUILDINGS_Y : int = 1082;
		public const BIG_BUILDINGS_Y : int = 762;
		public const BIG_BUILDINGS_SPACING : int = 1600; // the buildings are 1280 wide
		
		public const SCROLL_BUILDINGS_X : Number = 0.8; // Speed at which buildings scroll
		public const SCROLL_BUILDINGS_Y : Number = 1; // Speed at which buildings scroll
		
		public var sky : FlxSprite;
		public var buildings: FlxGroup;
		public var grounds : FlxGroup;
		public var poisons: FlxGroup;
		public var spikes: FlxGroup;
		
		private var poisons1: FlxSprite;
		
		public var boxstacles : FlxGroup;
		public var boxstacleTops : FlxGroup;
		//public var wrapper : WrappingSprite;
		
		public function Level() 
		{
			sky = new FlxSprite(0, 0);
			sky.loadGraphic(SkySprite, false, false, 640, 1440);
			sky.scrollFactor.x = 0;
			sky.solid = false;
			
			spikes = new FlxGroup();
			//var spikes1: FlxSprite = new FlxSprite(250, 1250, Spikes);
			//spikes.add(spikes1);
			var spikes2: FlxSprite = new FlxSprite(640 * 4 + 350, 1310, Spikes);
			spikes.add(spikes2);
			
			PlacePoisons();
			PlaceGrounds();
			PlaceBuildings();
			
			boxstacles = new FlxGroup();
			boxstacleTops = new FlxGroup();
			
			var box01 : Boxstacle = new Boxstacle(100, 1280);
			var boxTop01 : BoxstacleTop = new BoxstacleTop(100, 1280);
			boxstacles.add(box01);
			boxstacleTops.add(boxTop01);
			
			//wrapper = new WrappingSprite(300, 100, 48, 48, TestImage, 3, 0, 0, 2);
			
			AddElements();
		}
		
		public function AddElements() : void
		{
			FlxG.state.add(sky);
			FlxG.state.add(buildings);
			FlxG.state.add(grounds);
			FlxG.state.add(boxstacles);
			FlxG.state.add(boxstacleTops);
			FlxG.state.add(spikes);
			FlxG.state.add(grounds);
			FlxG.state.add(poisons);
			
			//FlxG.state.add(wrapper);
		}
		
		public function update() : void
		{
			poisons1.play("PlayAnimation");
		}
		
		public function PlacePoisons() : void
		{
			poisons = new FlxGroup();
			//loadGraphic(Poison, true, true, 50, 100);
			
			//addAnimation("idle", [1,2,3]);
			for (var i : int = 0; i < 5; i++)
			{
				if(i == 0){
					poisons1 = new FlxSprite(640 * 1 + 205, 1250);
				}
				else if (i == 1) {
					poisons1 = new FlxSprite(640 * 2 + 500, 1310);
				}
				else if (i == 2) {
					poisons1 = new FlxSprite(640 * 2 + 600, 1310);
				}
				else if (i == 3) {
					poisons1 = new FlxSprite(640 * 3 + 30, 1310);
				}
				else if (i == 4) {
					poisons1 = new FlxSprite(640 * 3 + 150, 1310);
				}
				poisons1.loadGraphic(Poison, true, false, 50, 110);
				poisons1.addAnimation("PoisonAnimation", [0,1,2],3);
				poisons.add(poisons1);
			}
		}
		
		public function PlaceBuildings() : void
		{
			buildings = new FlxGroup();
			
			for (var i:int = 0; i < NUM_BUILDING_LOOPS; i++)
			{
				for (var k:int = 0; k < 2; k++)
				{
					var little : FlxSprite = new FlxSprite(540 + BIG_BUILDINGS_SPACING * i + (k * 300), LITTLE_BUILDINGS_Y);
					var picker : int = new int(Math.ceil(Math.random() * 7));
					switch (picker)
					{
						case 1:
							little.loadGraphic(BuildingSmall1);
							break;
						case 2:
							little.loadGraphic(BuildingSmall2);
							break;
						case 3:
							little.loadGraphic(BuildingSmall3);
							little.y -= 160;
							break;
						case 4:
							little.loadGraphic(BuildingSmall4);
							break;
						case 5:
							little.loadGraphic(BuildingSmall5);
							break;
						case 6:
							little.loadGraphic(BuildingSmall6);
							break;
						case 7:
							little.loadGraphic(BuildingSmall7);
							break;
						default:
							little.loadGraphic(BuildingSmall1);
							break;
					}
					little.scrollFactor.x = SCROLL_BUILDINGS_X;
					little.scrollFactor.y = SCROLL_BUILDINGS_Y;
					buildings.add(little);
				}
			}
			
			
			for (i = 0; i < NUM_BUILDING_LOOPS / 2 + 1; i++)
			{
				var bigHigh : FlxSprite = new FlxSprite( -640 + BIG_BUILDINGS_SPACING * i * 2, BIG_BUILDINGS_Y);
				bigHigh.loadGraphic(BuildingHugeHigh);
				bigHigh.scrollFactor.x = SCROLL_BUILDINGS_X;
				bigHigh.scrollFactor.y = SCROLL_BUILDINGS_Y;
				buildings.add(bigHigh);
			}
			
			for (i = 0; i < NUM_BUILDING_LOOPS / 2; i++)
			{
				var bigLow : FlxSprite = new FlxSprite( -640 + BIG_BUILDINGS_SPACING + BIG_BUILDINGS_SPACING * i * 2, BIG_BUILDINGS_Y);
				bigLow.loadGraphic(BuildingHugeLow);
				bigLow.scrollFactor.x = SCROLL_BUILDINGS_X;
				bigLow.scrollFactor.y = SCROLL_BUILDINGS_Y;
				buildings.add(bigLow);
			}
			
			
			
		}
		
		public function PlaceGrounds() : void
		{
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
		}
		
	}

}