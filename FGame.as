package Framework
{
	import flash.display.Sprite;
	import flash.display.Graphics;

	import flash.events.*;

	import Framework.FG;
	import Framework.FInvalidURL;

	import Framework.Utils.FInternet;

	import flash.utils.getTimer;

	public class FGame extends Sprite
	{

		// Scene
		protected var sceneMask:Sprite;
		public var useMask:Boolean;
		protected var scene:FScene;
		public var _requestedScene:FScene
		public var switchingScene:Boolean;
		public var transitionFunc:Function;
		public var transitionTime:Number;
		public var transitionTimeLeft:Number;

		protected var gameURL:String;

		public var allowedURLs:Array;

		public function FGame(g:FGame, w:int, h:int, s:Class):void
		{
			FG.Init(g, w, h);

			FG._scene = scene = new s();
			_requestedScene = scene;

			addChild(scene);

			// Once we have a reference to Flash we can do our thing
			addEventListener(Event.ENTER_FRAME, Create);
		}

		public function Create(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, Create);

			// Check if we're on an allowed website
			var validURL:Boolean = false;
			if(allowedURLs != null)
			{
				for each(var u:String in allowedURLs)
				{
					if(FInternet.ValidURL(this, u, true))
					{
						validURL = true;
						break;
					}
				}
			}
			else
			{
				validURL = true;
			}

			if(!validURL)
				invalidURL();

			switchingScene = false;
			useMask = true;
			InitScene();

			// Necessary to have the proper delta time value on first scene update call
			FG.UpdateTime();

			// Mouse hooks
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);

			// Keyboard hooks
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			//stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

			// Think/draw hook
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		// Only called outside of this class if you want to modify the default parameters
		public function InitScene():void
		{
			if(useMask)
			{
				sceneMask = new Sprite();
				sceneMask.graphics.beginFill(0);
				sceneMask.graphics.drawRect(0, 0, FG.width, FG.height);
				sceneMask.graphics.endFill();
				
				// Gotta be on the stage to respond to Flash player resizing
				addChild(sceneMask);

				scene.mask = sceneMask;
			}
		}

		// The top level game loop
		protected function onEnterFrame(e:Event):void
		{
			// Update the time elapsed since the last frame
			FG.UpdateTime();
			FG.mouse.Update();

			// Switch scene
			if(scene != _requestedScene && !switchingScene)
				SwitchScene();
			if(switchingScene)
				AnimateScene();

			// Do game logic
			scene.Update();

			// Draw all game objects
			scene.Draw();
		}

		// Change active scene being run in the game loop
		protected function SwitchScene():void
		{
			if(transitionTimeLeft > 0 && transitionFunc != null)
			{
				switchingScene = true;
				addChild(_requestedScene);
				_requestedScene.paused = true;
			}
			else
			{
				if(switchingScene)
				{
					removeChild(_requestedScene);
					_requestedScene.paused = false;
				}
				scene.Destroy();
				removeChild(scene);
				scene = _requestedScene;
				FG._scene = scene;
				addChild(scene);
				InitScene();
				switchingScene = false;
			}
		}

		protected function AnimateScene():void
		{
			transitionTimeLeft -= FG.dt;

			if(transitionTimeLeft + FG.dt == 0 || transitionFunc == null)
				SwitchScene();

			// Guarantee we get to the exact end point of our transition time
			if(transitionTimeLeft < 0)
				transitionTimeLeft = 0;

			// Paused by default, but can be switched on manually
			_requestedScene.Update();
			_requestedScene.Draw();

			if(transitionFunc is Function)
				transitionFunc(scene, _requestedScene, transitionTimeLeft / transitionTime);
		}

		protected function invalidURL():void
		{
			_requestedScene = new FInvalidURL();
		}

		// Pass events mouse object
		protected function onMouseDown(e:MouseEvent):void { FG.mouse.onDown(e); }
		protected function onMouseUp(e:MouseEvent):void { FG.mouse.onUp(e); }
		protected function onMouseWheel(e:MouseEvent):void { FG.mouse.onWheel(e); }
	}

}