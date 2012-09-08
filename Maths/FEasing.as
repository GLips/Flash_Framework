// Courtesy of http://gizma.com/easing/
// Robert Penner

package Framework.Maths
{
	public class FEasing
	{
		// loc = Location (between 0 and 1)
		// end = End Value
		// start = Start Value

		public static function Linear(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return mult*loc + start;
		}

		public static function QuadIn(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return mult*loc*loc + start;
		}

		public static function QuadOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return -mult * loc*(loc-2) + start;
		}

		public static function QuadInOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			loc *= 2;
			if (loc < 1) return mult/2*loc*loc + start;
			
			loc--;
			return -mult/2 * (loc*(loc-2) - 1) + start;
		}

		public static function CubicIn(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return mult*loc*loc*loc + start;
		}

		public static function CubicOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			loc--;
			return mult*(loc*loc*loc + 1) + start;
		}

		public static function CubicInOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			loc *= 2;
			if (loc < 1) return mult/2*loc*loc*loc + start;

			loc -= 2;
			return mult/2*(loc*loc*loc + 2) + start;
		}

		public static function QuarticIn(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return end*loc*loc*loc*loc + start;
		}

		public static function QuarticOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return mult*loc*loc*loc*loc + start;
		}

		public static function QuarticInOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			loc *= 2;
			if (loc < 1) return mult/2*loc*loc*loc*loc + start;

			loc -= 2;
			return -mult/2 * (loc*loc*loc*loc - 2) + start;
		}

		public static function SineIn(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return -mult * Math.cos(loc * (Math.PI/2)) + mult + start;
		}

		public static function SineOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return mult * Math.sin(loc * (Math.PI/2)) + start;
		}

		public static function SineInOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return -mult/2 * (Math.cos(Math.PI*loc) - 1) + start;
		}

		public static function ExpoIn(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return mult * Math.pow( 2, 10 * (loc - 1) ) + start;
		}

		public static function ExpoOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return mult * ( -Math.pow( 2, -10 * loc ) + 1 ) + start;
		}

		public static function ExpoInOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			loc *= 2;
			if (loc < 1) return mult/2 * Math.pow( 2, 10 * (loc - 1) ) + start;

			loc--;
			return mult/2 * ( -Math.pow( 2, -10 * loc) + 2 ) + start;
		}

		public static function CircIn(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			return -mult * (Math.sqrt(1 - loc*loc) - 1) + start;
		}

		public static function CircOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			loc--;
			return mult * Math.sqrt(1 - loc*loc) + start;
		}

		public static function CircInOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			loc *= 2;
			if (loc < 1) return -mult/2 * (Math.sqrt(1 - loc*loc) - 1) + start;
			
			loc -= 2;
			return mult/2 * (Math.sqrt(1 - loc*loc) + 1) + start;
		}
		
		public static function ElasticIn(loc:Number, start:Number, end:Number):Number
		{
			var s:Number = 1.70158;
			var p:Number = 0.3;
			var mult:Number = end - start;
			var a:Number = mult;

			if (loc == 0)
				return start;
			
			if (loc == 1)
				return end;
			
			if (a < Math.abs(mult))
			{
				a = mult;
				s = p/4;
			}
			else
			{
				s = p/(2*Math.PI) * Math.asin (mult/a);
			}

			return -(a*Math.pow(2,10*(loc-=1)) * Math.sin( (loc-s)*(2*Math.PI)/p )) + start;
		}

		public static function ElasticOut(loc:Number, start:Number, end:Number):Number
		{
			var s:Number = 1.70158;
			var p:Number = 0.3;
			var mult:Number = end - start;
			var a:Number = mult;

			if (loc == 0)
				return start;
			if (loc == 1)
				return end;

			if (a < Math.abs(mult))
			{
				a = mult;
				s = p/4;
			}
			else 
			{
				s = p/(2*Math.PI) * Math.asin (mult/a);
			}
			return a*Math.pow(2,-10*loc) * Math.sin( (loc-s)*(2*Math.PI)/p ) + end + start;
		}

		public static function ElasticInOut(loc:Number, start:Number, end:Number):Number
		{
			var s:Number = 1.70158;
			var p:Number = 0.45;
			var mult:Number = end - start;
			var a:Number = mult;

			loc *= 2;

			if (loc == 0)
				return start;
			if (loc == 2)
				return end;
			if (a < Math.abs(mult))
			{
				a = mult;
				s = p/4;
			}
			else
			{
				s = p/(2*Math.PI) * Math.asin (mult/a);
			}

			if (loc < 1)
			{
				return -.5*(a*Math.pow(2,10*(loc-=1)) * Math.sin( (loc-s)*(2*Math.PI)/p )) + start;
			}
			
			return a*Math.pow(2,-10*(loc-=1)) * Math.sin( (loc-s)*(2*Math.PI)/p )*.5 + mult + start;
		}

		// c = end
		// t/d = loc
		// b = start

		
		public static function BackIn(loc:Number, start:Number, end:Number):Number
		{
			var s:Number = 1.70158;
			var mult:Number = end - start;
			return mult*loc*loc*((s+1)*loc - s) + start;
		}

		public static function BackOut(loc:Number, start:Number, end:Number):Number
		{
			var s:Number = 1.70158;
			var mult:Number = end - start;
			return mult*(loc*loc*((s+1)*loc + s) + 1) + start;
		}

		public static function BackInOut(loc:Number, start:Number, end:Number):Number
		{
			var s:Number = 2.5949095;
			var mult:Number = end - start;
			
			loc *= 2;

			if (loc < 1)
				return mult/2*(loc*loc*((s+1)*loc - s)) + start;

			return mult/2*((loc-=2)*loc*((s+1)*loc + s) + 2) + start;
		}
		
		public static function BounceIn(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			loc = 1 - loc;
			if (loc < B1) return mult * (1 - 7.5625 * loc * loc) + start;
			if (loc < B2) return mult * (1 - (7.5625 * (loc - B3) * (loc - B3) + .75)) + start;
			if (loc < B4) return mult * (1 - (7.5625 * (loc - B5) * (loc - B5) + .9375)) + start;
			return mult * (1 - (7.5625 * (loc - B6) * (loc - B6) + .984375)) + start;
		}

		public static function BounceOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			if (loc < B1) return mult * (7.5625 * loc * loc) + start;
			if (loc < B2) return mult * (7.5625 * (loc - B3) * (loc - B3) + .75) + start;
			if (loc < B4) return mult * (7.5625 * (loc - B5) * (loc - B5) + .9375) + start;
			return mult * (7.5625 * (loc - B6) * (loc - B6) + .984375) + start;
		}

		public static function BounceInOut(loc:Number, start:Number, end:Number):Number
		{
			var mult:Number = end - start;
			if (loc < .5)
			{
				loc = 1 - loc * 2;
				if (loc < B1) return mult * ((1 - 7.5625 * loc * loc) / 2) + start;
				if (loc < B2) return mult * ((1 - (7.5625 * (loc - B3) * (loc - B3) + .75)) / 2) + start;
				if (loc < B4) return mult * ((1 - (7.5625 * (loc - B5) * (loc - B5) + .9375)) / 2) + start;
				return mult * ((1 - (7.5625 * (loc - B6) * (loc - B6) + .984375)) / 2) + start;
			}
			loc = loc * 2 - 1;
			if (loc < B1) return mult * ((7.5625 * loc * loc) / 2 + .5) + start;
			if (loc < B2) return mult * ((7.5625 * (loc - B3) * (loc - B3) + .75) / 2 + .5) + start;
			if (loc < B4) return mult * ((7.5625 * (loc - B5) * (loc - B5) + .9375) / 2 + .5) + start;
			return mult * ((7.5625 * (loc - B6) * (loc - B6) + .984375) / 2 + .5) + start;
		}

		// Easing constants.
		private static const PI:Number = Math.PI;
		private static const PI2:Number = Math.PI / 2;
		private static const EL:Number = 2 * PI / .45;
		private static const B1:Number = 1 / 2.75;
		private static const B2:Number = 2 / 2.75;
		private static const B3:Number = 1.5 / 2.75;
		private static const B4:Number = 2.5 / 2.75;
		private static const B5:Number = 2.25 / 2.75;
		private static const B6:Number = 2.625 / 2.75;
		

	}
}