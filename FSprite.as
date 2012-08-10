package Framework
{
	import Framework.FG;
	import Framework.FObject;

	import Framework.Maths.FVec;

	public class FSprite extends FObject
	{
		// Movement variables
		public var velocity:FVec;
		public var rot:Number;
		public var gravity:FVec;
		public var friction:Number;

		

		// Get half widths for positioning
		public function get halfHeight():Number { return height/2; }
		public function get halfWidth():Number { return width/2; }

		public function FSprite(X:int = 0, Y:int = 0)
		{
			draws = true;

			super();
			
			x = X;
			y = Y;
		}

		override public function Create():void
		{
			velocity = new FVec();
			rot = 0;	// Rename rot;
			gravity = new FVec();
			friction = 0;
		}

		override public function Update():void
		{
			super.Update();

			trace(name+" is updating. Velocity is "+velocity+".");

			velocity.x += gravity.x * FG.dt;
			velocity.x *= friction;

			velocity.y += gravity.y * FG.dt;
			velocity.y *= friction;

			x += velocity.x * FG.dt;
			y += velocity.y * FG.dt;

			rotation += rot * FG.dt;
		}
	}
}