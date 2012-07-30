package Framework.Shapes
{
	public class FShape
	{

		public var loc:FPoint;

		public function FShape(X:int, Y:int = 0)
		{
			loc = new FPoint(X, Y);
		}
	}
}