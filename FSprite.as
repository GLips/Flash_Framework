package Framework
{
	import Framework.FG;
	import Framework.FObject;

	import Framework.Maths.FVec;

	public class FSprite extends FObject
	{
		// Movement variables
		public var velocity:FVec;
		public var spin:Number;
		public var acceleration:FVec;
		public var drag:FVec;
		public var maxSpeed:FVec;
		public var minSpeed:FVec;

		

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
			spin = 0;	// Rename rot;
			acceleration = new FVec();
			drag = new FVec();
			maxSpeed = new FVec();
			minSpeed = new FVec();
		}

		override public function Destroy():void
		{
			velocity = null;
			acceleration = null;
			drag = null;
			maxSpeed = null;
			minSpeed = null;
		}

		override public function Update():void
		{
			super.Update();

			//var velocityDelta:Number;
			velocity.x = computeVelocity(velocity.x, acceleration.x, drag.x, maxSpeed.x);
			velocity.y = computeVelocity(velocity.y, acceleration.y, drag.y, maxSpeed.y);
			//velocity.x += velocityDelta;

			/*
			velocityDelta = (FlxU.computeVelocity(velocity.x,acceleration.x,drag.x,maxVelocity.x) - velocity.x)/2;
			velocity.x += velocityDelta;
			delta = velocity.x*FlxG.elapsed;
			velocity.x += velocityDelta;
			x += velocity.x * friction;
			*/
			
			//velocity.x *= friction;

			//velocity.y += computeVelocity(velocity.y, acceleration.y, drag.y);
			//velocity.y *= friction;

			x += velocity.x;
			y += velocity.y;

			rotation += spin * FG.dt;
		}

		// Snagged from Flixel.
		private function computeVelocity(Velocity:Number, Acceleration:Number=0, Drag:Number=0, Max:Number=10000):Number
		{
			if(Acceleration != 0)
				Velocity += Acceleration*FG.dt;
			else if(Drag != 0)
			{
				var drag:Number = Drag*FG.dt;
				if(Velocity - drag > 0)
					Velocity = Velocity - drag;
				else if(Velocity + drag < 0)
					Velocity += drag;
				else
					Velocity = 0;
			}
			if((Velocity != 0) && (Max != 10000))
			{
				if(Velocity > Max)
					Velocity = Max;
				else if(Velocity < -Max)
					Velocity = -Max;
			}
			return Velocity;
		}

		public function SetXSpeed(min:int = -100, max:int = 100):void { minSpeed.x = min; maxSpeed.x = max; }
		public function SetYSpeed(min:int = -100, max:int = 100):void { minSpeed.y = min; maxSpeed.y = max; }

	}
}