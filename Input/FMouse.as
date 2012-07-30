package Framework.Input
{
	import flash.events.MouseEvent;

	import Framework.Shapes.FPoint;
	import Framework.FG;

	public class FMouse extends FPoint
	{

		public var wheel:int;

		protected var _lastX:Number;
		protected var _lastY:Number;

		// Track time between clicks
		protected var _last:int;
		protected var _current:int;

		public function FMouse()
		{
			// 
		}

		public function Update():void
		{
			_lastX = x;
			_lastY = y;

			x = FG.stage.mouseX;
			y = FG.stage.mouseY;

			if((_last == -1) && (_current == -1))
				_current = 0;
			else if((_last == 2) && (_current == 2))
				_current = 1;

			_last = _current;
		}

		public function onDown(e:MouseEvent):void
		{
			if(_current > 0)
				_current = 1;
			else
				_current = 2;
		}

		public function onUp(e:MouseEvent):void
		{
			if(_current > 0)
				_current = -1;
			else
				_current = 0;
		}

		// Wheel doesn't automatically reset to zero. Figure this out later. -- Graham
		public function onWheel(e:MouseEvent):void
		{
			wheel = e.delta;
		}

		public function isDown():Boolean { return _current == 1; }
		public function justPressed():Boolean { return _current == 2; }
		public function justReleased():Boolean { return _current == -1; }
		public function pressed():Boolean { return _current > 0; }
	}
}