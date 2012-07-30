package Framework.Shapes
{

	import Framework.Shapes.FShape;

	public class FRect extends FShape
	{
		
		public var width:int;
		public var height:int;

		public function FRect(X:int = 0, Y:int = 0, W:int = 0, H:int = 0)
		{
			super(X, Y)
			width = W;
			height = H;
		}
	}
}