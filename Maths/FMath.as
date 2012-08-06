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
			var mult:int = 1;
			while(precision > 0) { mult *= 10; precision--; }
			return Math.round(int(x * mult))/mult;
		}

		// Returns the number clamped with in the bounds given
		public static function clamp(x:Number, min:Number = 0, max:Number = 1):Number
		{
			if(x < min)
				return min;
			else if(x > max)
				return max;
			else
				return x;
		}
	}
}