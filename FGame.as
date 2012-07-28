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

		public function FGame(g:FGame, w:int, h:int, s:FScene):void
		{
			FG.Init(g, w, h, s);

			scene = s;

			addChild(scene);

			scene.Add(new FObject());

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

			// Update objects in the scene & do game logic
			scene.Update();

			// Update and draw game objects
			scene.Draw();
		}

		// Pass the event to the global mouse object
		protected function onMouseDown(e:MouseEvent):void { FG.mouse.onDown(e); }
		protected function onMouseUp(e:MouseEvent):void { FG.mouse.onUp(e); }
		protected function onMouseWheel(e:MouseEvent):void { FG.mouse.onWheel(e); }
	}

}