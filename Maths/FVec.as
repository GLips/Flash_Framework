package Framework.Maths
{

	import Framework.Maths.FPoint

	public class FVec extends FPoint
	{

		public function FVec(X:Number = 0, Y:Number = 0)
		{
			x = X;
			y = Y;
		}

		// Return the length of the vector
		public function Mag():Number
		{
			return Math.sqrt((x*x) + (y*y));
		}

		// Make the vector length = 1 while retaining the angle
		public function Normalize():void
		{
			var mag:Number = Mag();
			
			x /= mag;
			y /= mag;
		}

		// Multiply the length of the vector by the supplied number
		public function Mult(m:Number):void
		{
			x *= m;
			y *= m;
		}

		public function Add(p:FVec):void
		{
			x += p.x;
			y += p.y;
		}
	}
}