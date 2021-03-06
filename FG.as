package Framework
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Stage;

	import flash.utils.getTimer;

	import flash.system.System;

	import Framework.FGroup;
	import Framework.FSound;

	import Framework.Input.*;
	import Framework.Maths.FMath;

	public class FG
	{

		// Timekeeping
		public static var firstTime:int;
		public static var lastTime:int;
		public static var dt:Number;

		// Dimensions
		public static var width:int;
		public static var height:int;

		// Input
		public static var mouse:FMouse;

		// Sound
		public static var soundEngine:FSound;

		// The game object, used to get references to the stage
		public static var _game:FGame;

		// URL where the game should be played by default
		public static var gameURL:String;

		// The name of the game
		public static var gameName:String;

		// If we're using Mochiads, this will hold the unique ID
		public static var _mochiads_game_id:String;

		// Scenes
		public static var _scene:FScene;	// The most recently created scene
		public static var _newScene:FScene;	// The scene to switch to

		public function FG():void
		{
			// Global is a static class
			trace("Don't instantiate the Global Framework class.");
		}

		// Set up vars necessary for FG to track
		public static function Init(g:FGame, w:int, h:int):void
		{
			_game = g;
			FG.width = w;
			FG.height = h;
			//FG._scene = s;

			FG.firstTime = getTimer();
			FG.lastTime = firstTime;

			soundEngine = new FSound();
			soundEngine.Init();

			FG.mouse = new FMouse();
		}

		public static function UpdateTime():void
		{
			var curTime:int = getTimer();

			FG.dt = (curTime - FG.lastTime)/1000;
			FG.lastTime = curTime;
		}

		public static function SwitchScene(s:FScene, transitionFunc:Function = null, time:Number = 0):void
		{
			if(!_game.switchingScene)
			{
				_game._requestedScene = s;
				_game.transitionFunc = transitionFunc;
				_game.transitionTimeLeft = _game.transitionTime = time;
			}
		}

		// Return game's framerate
		public static function get framerate():Number { return FMath.Round(1/FG.dt); }

		// Return total memory used by Flash (includes output from every instance of Flash open currently)
        public static function get totalMemory():Number { return System.totalMemory; }

		public static function get stage():Stage
		{
			if(FG._game.stage != null)
				return FG._game.stage;
			return null;
		}

		// Takes two groups (or just sprites) of different shapes and collides them, calling onCollide when collisions happen
		/*public static function Collide(g1:FObject, g2:FObject, onCollide:Function):void
		{
			for(var i:int = g1.length - 1; i >= 0; i--)
			{
				if(members[i] != null)
				{
					Remove(members[i]).Destroy();
				}
			}
		}*/
	}

}