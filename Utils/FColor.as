package Framework.Utils
{
	public class FColor
	{
		public function FColor()
		{
			trace("Don't instantiate FColor.");
		}

		public static function RGBtoHEX(r:int, g:int, b:int):int
		{
			return r << 16 | g << 8 | b;
		}
	}
}