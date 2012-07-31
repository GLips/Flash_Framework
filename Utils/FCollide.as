package Framework.Utils
{

	import Framework.Shapes.*;

	public class FCollide
	{

		public function FCollide()
		{
			trace("Don't instantiate Framework.Util.FCollide.");
		}

		public static function PointInRect(point:FPoint, rect:FRect):Boolean
		{
			return (point.x >= rect.p.x && point.x <= rect.p.x + rect.width) && (point.y >= rect.p.y && point.y <= rect.p.y + rect.height);
		}

		public static function PointInCircle(point:FPoint, circle:FCircle):Boolean
		{
			return (point.x - circle.p.x) * (point.x - circle.p.x) + (point.y - circle.p.y) * (point.y - circle.p.y) < circle.radius * circle.radius;
		}

		public static function CircleCircle(cir1:FCircle, cir2:FCircle):Boolean
		{
			var dx:Number = cir1.p.x - cir2.p.x;
			var dy:Number = cir1.p.y - cir2.p.y;
			var r:Number = cir1.radius + cir2.radius;
			return (dx * dx)  + (dy * dy) < r * r;
		}
	}
}