package Framework
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Stage;

	import flash.utils.getTimer;

	import Framework.Input.*;
	import Framework.Maths.FMath;

	public class FG
	{

		// Timekeeping
		public static var firstTime:int;
		public static var lastTime:int;
		public static var dt:int;

		// Dimensions
		public static var width:int;
		public static var height:int;

		// Input
		public static var mouse:FMouse;

		// The game object, used to get references to the stage
		public static var _game:FGame;

		// Scenes
		public static var _scene:FScene;	// The current scene
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

			FG.mouse = new FMouse();
		}

		public static function UpdateTime():void
		{
			var curTime:int = getTimer();

			FG.dt = curTime - FG.lastTime;
			FG.lastTime = curTime;
		}

		public static function InitScene(s:FScene):void
		{
			_scene = s;
		}

		public static function SwitchScene(s:FScene, transition:int = 0):void
		{
			_game._requestedScene = s;
		}

		public static function get framerate():Number
		{
			return FMath.round(1000/FG.dt, 2);
		}

		public static function get stage():Stage
		{
			if(FG._game.stage != null)
				return FG._game.stage;
			return null;
		}
	}

}