package Framework
{

	import Framework.FG;
	import Framework.FSprite;

	public class FParticle extends FSprite
	{
		// Time left before death
		public var lifetime:Number;

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

			lifetime = 1;
		}

		override public function Update():void
		{
			super.Update();

			// Time to die?
			lifetime -= FG.dt;
			if(lifetime <= 0)
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
		* BEGIN PRIVATE FUNCTIONS
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