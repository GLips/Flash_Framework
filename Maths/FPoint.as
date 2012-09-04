package Framework.Maths
{

	import flash.geom.Point;

	public class FPoint extends Point
	{

		public function FPoint(X:Number = 0, Y:Number = 0)
		{
			super(X,Y);
		}

		public function Dot(p:FPoint):Number
		{
			return x * p.x + y * p.y;
		}
	}
}