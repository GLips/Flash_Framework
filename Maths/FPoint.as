package Framework.Maths
{
	public class FPoint
	{
		// Default = 0;
		public var x:Number;

		// Default = 0;
		public var y:Number;

		public function FPoint(X:Number = 0, Y:Number = 0)
		{
			x = X;
			y = Y;
		}

		public function Dot(p:FPoint):Number
		{
			return x * p.x + y * p.y;
		}
	}
}