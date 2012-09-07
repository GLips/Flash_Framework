package Framework.Maths
{
	public class FEasing
	{
		// loc = Location (between 0 and 1)
		// end = End Value
		// start = Start Value

		public static function Linear(loc:Number, start:Number, end:Number):Number
		{
			return end*loc + start;
		}

		public static function InQuad(loc:Number, start:Number, end:Number):Number
		{
			return end*loc*loc + start;
		}

		public static function OutQuad(loc:Number, start:Number, end:Number):Number
		{
			return -end * loc*(loc-2) + start;
		}

		public static function InOutQuad(loc:Number, start:Number, end:Number):Number
		{
			loc *= 2;
			if (loc < 1) return end/2*loc*loc + start;
			
			loc--;
			return -end/2 * (loc*(loc-2) - 1) + start;
		}

		public static function CubicIn(loc:Number, start:Number, end:Number):Number
		{
			return end*loc*loc*loc + start;
		}

		public static function CubicOut(loc:Number, start:Number, end:Number):Number
		{
			loc--;
			return end*(loc*loc*loc + 1) + start;
		}

		public static function CubicInOut(loc:Number, start:Number, end:Number):Number
		{
			loc *= 2;
			if (loc < 1) return end/2*loc*loc*loc + start;

			loc -= 2;
			return end/2*(loc*loc*loc + 2) + start;
		}

		public static function QuarticIn(loc:Number, start:Number, end:Number):Number
		{
			return end*loc*loc*loc*loc + start;
		}

		public static function QuarticOut(loc:Number, start:Number, end:Number):Number
		{
			return end*loc*loc*loc*loc + start;
		}

		public static function QuarticInOut(loc:Number, start:Number, end:Number):Number
		{
			loc *= 2;
			if (loc < 1) return end/2*loc*loc*loc*loc + start;

			loc -= 2;
			return -end/2 * (loc*loc*loc*loc - 2) + start;
		}

		public static function SineIn(loc:Number, start:Number, end:Number):Number
		{
			//return -c * Math.cos(t/d * (Math.PI/2)) + c + b;

			return -end * Math.cos(loc * (Math.PI/2)) + end + start;
		}

		public static function SineOut(loc:Number, start:Number, end:Number):Number
		{
			return end * Math.sin(loc * (Math.PI/2)) + start;
		}

		public static function SineInOut(loc:Number, start:Number, end:Number):Number
		{
			return -end/2 * (Math.cos(Math.PI*loc) - 1) + start;
		}

		public static function ExpoIn(loc:Number, start:Number, end:Number):Number
		{
			return end * Math.pow( 2, 10 * (loc - 1) ) + start;
		}

		public static function ExpoOut(loc:Number, start:Number, end:Number):Number
		{
			return end * ( -Math.pow( 2, -10 * loc ) + 1 ) + start;
		}

		public static function ExpoInOut(loc:Number, start:Number, end:Number):Number
		{
			loc *= 2;
			if (loc < 1) return end/2 * Math.pow( 2, 10 * (loc - 1) ) + start;

			loc--;
			return end/2 * ( -Math.pow( 2, -10 * loc) + 2 ) + start;
		}

		public static function CircIn(loc:Number, start:Number, end:Number):Number
		{
			return -end * (Math.sqrt(1 - loc*loc) - 1) + start;
		}

		public static function CircOut(loc:Number, start:Number, end:Number):Number
		{
			loc--;
			return end * Math.sqrt(1 - loc*loc) + start;
		}

		public static function CircInOut(loc:Number, start:Number, end:Number):Number
		{
			loc *= 2;
			if (loc < 1) return -end/2 * (Math.sqrt(1 - loc*loc) - 1) + start;
			
			loc -= 2;
			return end/2 * (Math.sqrt(1 - loc*loc) + 1) + start;
		}
	}
}