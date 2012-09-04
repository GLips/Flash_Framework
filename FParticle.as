package Framework
{

	import Framework.FG;
	import Framework.FSprite;

	import Framework.Maths.FMath;

	public class FParticle extends FSprite
	{
		// Time left before death
		public var timeLeft:Number;
		// Total time particle will have lived by the end
		public var _lifetime:Number;
		public function get lifetime():Number { return _lifetime; }
		public function set lifetime(x:Number):void { _lifetime = timeLeft = x; }

		// Rendering function
		public var drawFunc:Function;


		/**********************
		*
		* INSTANTIATION
		*
		**********************/
		public function FParticle()
		{
			super();
			drawFunc = defaultDraw;
		}


		/**********************
		*
		* FOBJECT OVERRIDES
		*
		**********************/
		override public function Create():void
		{
			super.Create();

			timeLeft = lifetime = 1;
		}

		override public function Update():void
		{
			super.Update();

			// Time to die?
			timeLeft -= FG.dt;
			if(timeLeft <= 0)
				Kill();
		}

		override public function Draw():void
		{
			super.Draw();
			drawFunc();
		}

		/**********************
		*
		* CLASS SPECIFIC FUNCTIONS
		*
		**********************/
		public function OnEmit():void
		{
			// Called when emitted by a particle
		}


		/**********************
		*
		* PRIVATE FUNCTIONS
		*
		**********************/
		private function defaultDraw():void
		{
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(-5, -5, 10, 10);
			graphics.endFill();
			draws = false;
		}
	}
}