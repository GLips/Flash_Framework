package Framework.Shapes
{

	import Framework.Maths.FPoint;

	public class FShape
	{

		public var p:FPoint;

		public function FShape(X:int, Y:int = 0)
		{
			p = new FPoint(X, Y);
		}
	}
}