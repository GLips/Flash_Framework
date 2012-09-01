package Framework.Utils
{
	import flash.utils.Dictionary;

	import Framework.FObject;

	import Framework.Maths.FMath;
	import Framework.Maths.FPoint;

	public class FInterpolator extends FObject
	{
		// Holds FPoints where x == location on the number line and y == the value.
		// Ordered by location on the number line from least to greatest.
		private var pointHolder:Array;

		// Holds different interpolations functions
		private var funcHolder:Array;

		// Function to be used to determine values
		private var currentFunction:Function;

		// Interpolation methods used to access functions
		public static const LINEAR:String = "linear";

		public function FInterpolator()
		{
			super();
		}

		override public function Create():void
		{
			super.Create();

			pointHolder = new Array();
			
			// Insert default starting points, can be overwritten
			pointHolder[0] = new FPoint(0, 0);
			pointHolder[1] = new FPoint(1, 1);

			// Set up the function holder
			funcHolder = new Array();
			funcHolder[LINEAR] = linear;

			// Set default function for interpolation
			currentFunction = linear;
		}

		override public function Destroy():void
		{

		}

		public function SetValue(location:Number, value:Number):void
		{

		}

		public function GetValue(location:Number):Number
		{
			// Get a value between 0 and 1
			location = FMath.Clamp(location);

			var p1:FPoint;
			var p2:FPoint;

			// Find the two values on either side of the given location
			for(x = 0; x < pointHolder.length; x++)
			{
				p2 = pointHolder[x];

				// If we're on a pre-defined point, no need to run lerp
				if(p2.x == location)
					return p2.y;

				if(p2.x > location)
				{
					p1 = pointHolder[x-1];
					break;
				}
			}

			// Run the chosen function to determine value
			return currentFunction(location, p1, p2);
		}

		private function linear(location:Number, p1:FPoint, p2:FPoint):Number
		{
			return p1.y + (p2.y - p1.y) * (location - p1.x)/(p2.x - p1.x);
		}
	}
}