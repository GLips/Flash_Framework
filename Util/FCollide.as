package Framework.Util
{

	import Framework.Shapes.*;

	public class FCollide
	{

		public function FCollide()
		{
			trace("Don't instantiate Framework.Util.FCollide.")
		}

		public static function PointInRect(point:FPoint, rect:FRect):Boolean
		{
			return (point.x >= rect.p.x && point.x <= rect.p.x + rect.width) && (point.y >= rect.p.y && point.y <= rect.p.y + rect.height)
		}
	}
}