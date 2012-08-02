package Framework.Maths
{
	public class FMath
	{
		public function FMath():void
		{
			trace("Don't instantiate Framework.Maths.FMath.");
		}

		public static function RadiansToDegrees(x:Number):Number { return x / 0.0174533; }
		public static function DegreesToRadians(x:Number):Number { return x / 57.2958; }

		// Round a number to a number of decimal places
		public static function round(x:Number, precision:int = 0):Number
		{
			precision = 10^precision;
			return Math.round(x * precision)/precision;
		}
	}
}