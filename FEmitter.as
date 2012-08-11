package Framework
{

	import Framework.FGroup;
	import Framework.FParticle;
	import Framework.Maths.FVec;

	public class FEmitter extends FGroup
	{

		public var maxSpeed:FVec;
		public var minSpeed:FVec;
		public var maxRotation:Number;
		public var minRotation:Number;
		public var lifetime:Number;
		public var drag:FVec;
		public var acceleration:FVec;

		public var Width:uint;
		public var Height:uint;

		public function FEmitter(X:int = 0, Y:int = 0, maxSize:uint = 0)
		{
			maxSpeed = new FVec();
			minSpeed = new FVec();

			super(maxSize);
			
			x = X;
			y = Y;
		}


		/**********************
		*
		* FOBJECT OVERRIDES
		*
		**********************/
		override public function Create():void
		{
			super.Create();
			SetXSpeed();	// Defaults to -100, 100
			SetYSpeed();	// Defaults to -100, 100
			acceleration = new FVec(0, 50);
			drag = new FVec(50, 0);
			maxRotation = 360;
			minRotation = -360;
			lifetime = 1;
			SetSize();
		}

		override public function Destroy():void
		{
			super.Destroy();
			maxSpeed = null;
			minSpeed = null;
			acceleration = null;
			drag = null;
		}

		override public function Update():void
		{
			// Handle emitting over time vs. explosions
			super.Update();
		}


		/**********************
		*
		* CLASS SPECIFIC FUNCTIONS
		*
		**********************/

		// Launch ze particles!
		public function Start():void
		{
			for(var i:int = 0; i < length; i++)
			{
				EmitParticle();
			}
		}

		public function EmitParticle():void
		{
			var particle:FParticle = FG._scene.Recycle(FParticle) as FParticle;
			particle.lifetime = lifetime;

			// Set up velocity
			var v:FVec = new FVec();
			if(maxSpeed.x != minSpeed.x)
				v.x = minSpeed.x + Math.random() * (maxSpeed.x - minSpeed.x);
			else
				v.x = minSpeed.x;
			if(maxSpeed.y != minSpeed.y)
				v.y = minSpeed.y + Math.random() * (maxSpeed.y - minSpeed.y);
			else
				v.y = minSpeed.y;
			particle.velocity = v;

			particle.SetXSpeed(minSpeed.x, maxSpeed.x);
			particle.SetYSpeed(minSpeed.y, maxSpeed.y);

			particle.drag = drag;

			// Set up inital particle rotation and rotation speed
			if(maxRotation != minRotation)
				particle.spin = minRotation + Math.random() * (maxRotation - minRotation);
			else
				particle.spin = minRotation;
			particle.rotation = Math.random() * maxRotation + minRotation;

			particle.acceleration = acceleration;
			particle.Reset(Math.random() * Width + x, Math.random() * Height + y);
			
			particle.OnEmit();
		}

		// Pre-make particles to limit possible momentary lag during game time
		public function Make(particleType:Class = null, num:uint = 50):FEmitter
		{
			_maxSize = num;

			var p:FParticle;
			var v:FVec;
			var r:Number;
			for(var i:int = 0; i < num; i++)
			{
				if(particleType == null)
					p = new FParticle();
				else
					p = new particleType();
				Add(p);
				p.Kill();
			}
			return this;
		}

		public function SetSize(W:uint = 1, H:uint = 1):void { Width = W; Height = H; }
		public function SetXSpeed(min:int = -25, max:int = 25):void { minSpeed.x = min; maxSpeed.x = max; }
		public function SetYSpeed(min:int = -25, max:int = 25):void { minSpeed.y = min; maxSpeed.y = max; }
	}
}