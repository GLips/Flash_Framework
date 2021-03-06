package Framework.Utils
{
	import flash.utils.Dictionary;

	import Framework.FObject;

	import Framework.Maths.FMath;
	import Framework.Maths.FPoint;
	import Framework.Maths.FEasing;

	public class FInterpolator extends FObject
	{
		// Holds FPoints where x == location on the number line and y == value.
		// Ordered by location on the number line from least to greatest.
		private var pointHolder:Array;

		// Holds different interpolations functions
		private var funcHolder:Array;

		// Function to be used to determine values
		private var currentFunction:Function;

		// Interpolation methods used to access functions
		public static const LINEAR:String = "linear";
		public static const SPLINE:String = "spline";
		public static const SINE:String = "sine";


		/**********************
		*
		* INSTANTIATION
		*
		**********************/
		public function FInterpolator(startValue:Number = 0, endValue:Number = 1)
		{
			super();

			pointHolder = new Array();
			
			// Insert default starting points, can be overwritten
			pointHolder[0] = new FPoint(0, startValue);
			pointHolder[1] = new FPoint(1, endValue);
		}


		/**********************
		*
		* FOBJECT OVERRIDES
		*
		**********************/
		override public function Create():void
		{
			super.Create();

			// Set up the function holder
			funcHolder = new Array();
			funcHolder[LINEAR] = linear;
			funcHolder[SPLINE] = spline;
			funcHolder[SINE] = sine;

			// Set default function for interpolation
			currentFunction = spline;
		}

		override public function Destroy():void
		{
			super.Destroy();


		}

		/**********************
		*
		* CLASS SPECIFIC FUNCTIONS
		*
		**********************/
		public function AddValue(location:Number, value:Number):void
		{
			// Get a value between 0 and 1
			location = FMath.Clamp(location);

			var newPoint:FPoint = new FPoint(location, value);
			var p1:FPoint;

			// Find the two values on either side of the given location
			var nearPoints:Array = getNearestPointIndices(location);
			var rightIndex:int = nearPoints[1];

			// Right and left will be the same if you're on a point so you could check either
			if(pointHolder[rightIndex].x == location)
				pointHolder[rightIndex].y = value;
			else
				pointHolder.splice(rightIndex, 0, newPoint)

			/*
			for(x = 0; x < pointHolder.length; x++)
			{
				p1 = pointHolder[x];

				// Replace the old value if we're on a point that has been defined
				if(p1.x == location)
				{
					p1.y = value;
					return;
				}

				if(p1.x > location)
				{
					pointHolder.splice(x, 0, newPoint);
					break;
				}
			}
			*/
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

				// If we're on a pre-defined point, no need to run interpolation
				if(p2.x == location)
					return p2.y;

				// Value just became greater than that of our loc, we have our outer bound
				if(p2.x > location)
				{
					p1 = pointHolder[x-1];
					break;
				}
			}

			// Run the chosen function to determine value
			return currentFunction(location);
		}

		// Change the method being used to interpolate values
		public function ChangeMethod(s:String):void
		{
			if(funcHolder[s] != null)
				currentFunction = funcHolder[s];
			else
				return;
		}


		/**********************
		*
		* PRIVATE FUNCTIONS
		*
		**********************/
		// Why return indices instead of points themselves?
		private function getNearestPointIndices(location:Number, numToGet:Number = 2):Array
		{
			var p:FPoint;

			// Find the two values on either side of the given location
			for(x = 0; x < pointHolder.length; x++)
			{
				p = pointHolder[x];

				// If we're on a pre-defined point, return the point itself
				if(p.x == location)
					return new Array(x, x);

				// Value just became greater than that of our loc, we have our outer bound
				if(p.x > location)
					break;
			}

			var ret:Array = new Array();
			
			for(var i:int = -numToGet/2; i < numToGet/2; i++)
			{
				ret.push((i+x + pointHolder.length) % pointHolder.length);
			}
			return ret;
		}
		private function getNearestPoints(location:Number, numToGet:Number = 2):Array
		{	
			var a:Array = getNearestPointIndices(location, numToGet);

			var ret:Array = new Array();
			
			for(var i:int = 0; i < a.length; i++)
			{
				ret.push(pointHolder[a[i]]);
			}

			return ret;
		}

		private function getRelativeLocation(location:Number, x1:Number, x2:Number):Number
		{
			return (location - x1) / (x2 - x1);
		}


		// Begin interpolation functions
		private function linear(location:Number):Number
		{
			var a:Array = getNearestPoints(location);

			var p1:FPoint = a[0];
			var p2:FPoint = a[1];

			return p1.y + (p2.y - p1.y) * (location - p1.x)/(p2.x - p1.x);
		}

		// See http://www.mvps.org/directx/articles/catmull/
		private function spline (location:Number):Number 
		{
			var a:Array = getNearestPoints(location, 4);

			var p0:FPoint = a[0];
			var p1:FPoint = a[1];
			var p2:FPoint = a[2];
			var p3:FPoint = a[3];

			var t:Number = getRelativeLocation(location, p1.x, p2.x);

			// Matrix math that I don't fully understand
			return 0.5 * (( 2 * p1.y) +
					t * (( -p0.y + p2.y) +
					t * ((2*p0.y -5*p1.y +4*p2.y -p3.y) +
					t * (  -p0.y +3*p1.y -3*p2.y +p3.y))))
		}

		private function sine (location:Number):Number
		{
			var a:Array = getNearestPoints(location);

			var p0:FPoint = a[0];
			var p1:FPoint = a[1];

			return FEasing.SineInOut(getRelativeLocation(location, p0.x, p1.x), p0.y, p1.y);
		}
	}
}