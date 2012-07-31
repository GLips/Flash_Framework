package Framework
{
	import flash.display.Sprite;
	import flash.display.Graphics;

	import flash.events.*;

	import flash.utils.getTimer;

	public class FGame extends Sprite
	{

		// Scene
		protected var scene:FScene;
		public var _requestedScene:FScene

		public function FGame(g:FGame, w:int, h:int, s:Class):void
		{
			FG.Init(g, w, h);

			scene = new s();
			_requestedScene = scene;

			FG.InitScene(scene);

			addChild(scene);

			// Once we have a reference to Flash we can do our thing
			addEventListener(Event.ENTER_FRAME, Create);
		}

		public function Create(e:Event):void
		{
			// Mouse hooks
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);

			// Keyboard hooks
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			//stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		protected function onEnterFrame(e:Event):void
		{
			// Update the time elapsed since the last frame
			FG.UpdateTime();
			FG.mouse.Update();

			if(scene != _requestedScene)
				SwitchScene();

			// Update objects in the scene & do game logic
			scene.Update();

			// Update and draw game objects
			scene.Draw();
		}

		protected function SwitchScene():void
		{
			scene.Destroy();
			removeChild(scene);
			scene = _requestedScene;
			addChild(scene);
			scene.Create();
		}

		// Pass events mouse object
		protected function onMouseDown(e:MouseEvent):void { FG.mouse.onDown(e); }
		protected function onMouseUp(e:MouseEvent):void { FG.mouse.onUp(e); }
		protected function onMouseWheel(e:MouseEvent):void { FG.mouse.onWheel(e); }
	}

}