package Framework
{
	
	import Framework.FObject;

	public class FSprite extends FObject
	{

		// Get half widths for positioning
		public function get halfHeight():Number { return height/2; }
		public function get halfWidth():Number { return width/2; }

		public function FSprite(X:int = 0, Y:int = 0)
		{
			draws = true;

			super();
			
			x = X;
			y = Y;
		}
	}
}