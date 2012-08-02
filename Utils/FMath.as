package Framework.Utils
{
	public class FMath
	{
		public function FMath():void
		{
			trace("Don't instantiate FMath.");
		}

		public static function RadiansToDegrees(x:Number):Number
		{
			return x / 0.0174533;
		}

		public static function DegreesToRadians(x:Number):Number
		{
			return x / 57.2958;
		}
	}
}