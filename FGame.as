package Framework
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.StageScaleMode;

	import flash.events.*;

	import Framework.FG;

	import flash.utils.getTimer;

	public class FGame extends Sprite
	{

		// Scene
		protected var scene:FScene;
		public var _requestedScene:FScene

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

			stage.scaleMode = StageScaleMode.NO_SCALE;

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

		// The top level game loop
		protected function onEnterFrame(e:Event):void
		{
			// Update the time elapsed since the last frame
			FG.UpdateTime();
			FG.mouse.Update();

			// Switch scene
			if(scene != _requestedScene)
				SwitchScene();

			// Do game logic
			scene.Update();

			// Draw all game objects
			scene.Draw();
		}

		// Change active scene being run in the game loop
		protected function SwitchScene():void
		{
			scene.Destroy();
			removeChild(scene);
			scene = _requestedScene;
			FG._scene = scene;
			addChild(scene);
		}

		// Pass events mouse object
		protected function onMouseDown(e:MouseEvent):void { FG.mouse.onDown(e); }
		protected function onMouseUp(e:MouseEvent):void { FG.mouse.onUp(e); }
		protected function onMouseWheel(e:MouseEvent):void { FG.mouse.onWheel(e); }
	}

}