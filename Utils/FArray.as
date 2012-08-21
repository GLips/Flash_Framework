package Framework.Utils
{
	public class FArray
	{
		public function FArray()
		{
			trace("Don't instantiate Framework.Utils.FArray");
		}

		public static function Sum(a:Array):Number
		{
			var total:Number = 0;

			for each(var x:Number in a)
			{
				total += x;
			}
			return total;
		}

		public static function Average(a:Array):Number
		{
			return FArray.Sum(a) / a.length;
		}

		public static function GetRandom(a:Array):*
		{
			return a[Math.round(Math.random() * (a.length - 1))];
		}
	}
}