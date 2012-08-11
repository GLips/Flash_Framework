package Framework.Utils
{

	import Framework.FG
	import Framework.FObject;

	public class FTimer extends FObject
	{

		protected var func:Function;
		public var seconds:Number;

		public function FTimer(S:Number, F:Function)
		{
			seconds = S;
			func = F;
		}

		override public function Create():void
		{
			draws = false;
		}

		override public function Destroy():void
		{
			super.Destroy();
			func = null;
		}

		override public function Update():void
		{
			seconds -= Number(FG.dt);
			if(seconds <= 0)
			{
				func();
				exists = false;	// Cleans itself up when spent
			}
		}
	}
}