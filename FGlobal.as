package Framework
{
	import flash.display.Sprite;
	import flash.display.Graphics;

	import flash.utils.getTimer;

	public class FGlobal
	{

		// Timekeeping
		public static var firstTime:int;
		public static var lastTime:int;
		public static var dt:int;

		public function FGlobal():void
		{
			// Global is a static class
			trace("Don't instantiate FGlobal.");
		}

		public static function Init():void
		{
			FGlobal.firstTime = getTimer();
			FGlobal.lastTime = firstTime;
		}

		public static function UpdateTime():void
		{
			FGlobal.dt = getTimer() - lastTime;
			FGlobal.lastTime = getTimer();
		}
	}

}