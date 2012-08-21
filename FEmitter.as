package Framework
{

	import Framework.FGroup;
	import Framework.FParticle;
	import Framework.Maths.FVec;

	public class FEmitter extends FGroup
	{

		public var maxSpeed:FVec;
		public var minSpeed:FVec;
		public var topSpeed:FVec;
		public var maxRotation:Number;
		public var minRotation:Number;
		public var lifetime:Number;
		public var drag:FVec;
		public var acceleration:FVec;

		public var Width:uint;
		public var Height:uint;

		// Track to help keep particles in the same position when this moves
		private var _lastX:int;
		private var _lastY:int;

		public function FEmitter(X:int = 0, Y:int = 0, maxSize:uint = 0)
		{
			maxSpeed = new FVec();
			minSpeed = new FVec();
			topSpeed = new FVec();

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
			SetXSpeed();	// Defaults to -25, 25
			SetYSpeed();	// Defaults to -25, 25
			SetMaxSpeed();
			acceleration = new FVec(0, 50);
			drag = new FVec(20, 0);
			maxRotation = 360;
			minRotation = -360;
			lifetime = 1;
			SetSize();

			_lastX = x;
			_lastY = y;
		}

		override public function Destroy():void
		{
			super.Destroy();
			maxSpeed = null;
			minSpeed = null;
			acceleration = null;
			drag = null;
			topSpeed = null;
		}

		override public function Update():void
		{
			// Handle emitting over time vs. explosions
			super.Update();

			_lastX = x;
			_lastY = y;
		}


		/**********************
		*
		* CLASS SPECIFIC FUNCTIONS
		*
		**********************/

		// Launch ze particles!
		public function Start():void
		{
			// Reset last positions on start in case emitter has just moved
			_lastX = x;
			_lastY = y;

			for(var i:int = 0; i < length; i++)
			{
				EmitParticle();
			}
		}

		public function EmitParticle():void
		{
			var particle:FParticle = Recycle(FParticle) as FParticle;
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
			particle.topSpeed = topSpeed;

			// Set up inital particle rotation and rotation speed
			if(maxRotation != minRotation)
				particle.spin = minRotation + Math.random() * (maxRotation - minRotation);
			else
				particle.spin = minRotation;
			particle.rotation = Math.random() * maxRotation + minRotation;

			particle.acceleration = acceleration;
			particle.Reset(Math.random() * Width, Math.random() * Height);
			
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

		// Keep particles in the same location in world space even if the emitter is moving
		public function UpdateParticleLocations():void
		{
			var deltaX:int = _lastX - x;
			var deltaY:int = _lastY - y;
			if(!paused && thinks && (deltaX != 0 || deltaY != 0))
			{
				for each(var o:FParticle in members)
				{
					if(o != null && o.exists && o.thinks)
					{
						o.x += deltaX;
						o.y += deltaY;
					}
				}
			}
		}

		public function SetSize(W:uint = 1, H:uint = 1):void { Width = W; Height = H; }
		public function SetMaxSpeed(maxX:int = 25, maxY:int = 25):void { topSpeed.x = maxX; topSpeed.y = maxY; }
		public function SetXSpeed(min:int = -25, max:int = 25):void { minSpeed.x = min; maxSpeed.x = max; }
		public function SetYSpeed(min:int = -25, max:int = 25):void { minSpeed.y = min; maxSpeed.y = max; }
	}
}