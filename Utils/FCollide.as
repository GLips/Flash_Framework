package Framework.Utils
{

	import Framework.Shapes.FShape;
	import Framework.Shapes.FRect;
	import Framework.Shapes.FCircle;

	import Framework.Maths.FPoint;

	public class FCollide
	{

		public function FCollide()
		{
			trace("Don't instantiate Framework.Util.FCollide.");
		}

		public static function PointInRect(point:FPoint, rect:FRect):Boolean
		{
			return (point.x >= rect.x && point.x <= rect.x + rect.width) && (point.y >= rect.y && point.y <= rect.y + rect.height);
		}

		public static function PointInCircle(point:FPoint, circle:FCircle):Boolean
		{
			return (point.x - circle.x) * (point.x - circle.x) + (point.y - circle.y) * (point.y - circle.y) < circle.radius * circle.radius;
		}

		public static function CircleCircle(cir1:FCircle, cir2:FCircle):Boolean
		{
			var dx:Number = cir1.x - cir2.x;
			var dy:Number = cir1.y - cir2.y;
			var r:Number = cir1.radius + cir2.radius;
			return (dx * dx)  + (dy * dy) < r * r;
		}
	}
}