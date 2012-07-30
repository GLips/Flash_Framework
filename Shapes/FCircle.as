package Framework.Shapes
{
	
	import Framework.Shapes.FShape;

	public class FCircle extends FShape
	{

		public var radius:int;

		public function FCircle(X:int = 0, Y:int = 0, R:int = 0)
		{
			super(X, Y);
			radius = R;
		}
	}
}