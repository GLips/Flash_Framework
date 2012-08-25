package Framework
{

	import Framework.FGroup;
	import Framework.FParticle;

	import Framework.Maths.FVec;
	import Framework.Maths.FMath;

	public class FEmitter extends FGroup
	{

		public var maxSpeed:FVec;
		public var minSpeed:FVec;
		public var topSpeed:FVec;
		public var maxRotation:Number;
		public var minRotation:Number;
		public var drag:FVec;
		public var acceleration:FVec;

		public var Width:uint;
		public var Height:uint;

		// Keep track of how to emit particles
		public var emitType:uint;
		public var quantity:int;
		public var interval:Number;
		public var lifetime:Number;

		// Constants to track emit type
		public static const EXPLODE:uint	= 1;
		public static const TIMED:uint		= 2;
		public static const CONSTANT:uint	= 3;

		private var emitTracker:Number;

		// Track to help keep particles in the same position when this moves
		private var _lastX:int;
		private var _lastY:int;

		public function FEmitter(X:int = 0, Y:int = 0, maxSize:uint = 0)
		{
			maxSpeed	= new FVec();
			minSpeed	= new FVec();
			topSpeed	= new FVec();
			drag		= new FVec();

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
			SetTopSpeed();
			acceleration = new FVec(0, 50);
			SetDrag();
			maxRotation = 360;
			minRotation = -360;
			lifetime = 1;
			SetSize();
			emitTracker = 0;

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

			if(emitType == EXPLODE)
			{
				emitType = 0;
				for(var i:int = 0; i < quantity; i++)
				{
					EmitParticle();
				}
			}
			else if(emitType == CONSTANT || emitType == TIMED)
			{
				var numToEmit:Number = FG.dt / interval + emitTracker;
				while(numToEmit >= 1)
				{
					EmitParticle();
					numToEmit--;
				}
				emitTracker = numToEmit;
			}

			_lastX = x;
			_lastY = y;
		}


		/**********************
		*
		* CLASS SPECIFIC FUNCTIONS
		*
		**********************/

		// Launch ze particles!
		public function Start(EmitType:uint = EXPLODE, Lifetime:Number = 1, Quantity:int = 0, Interval:Number = 0.1):void
		{
			// If emitter has moved, keep the emitted particles in the same place
			UpdateParticleLocations();

			emitType = EmitType;
			lifetime = Lifetime;
			interval = Interval;

			if(Quantity != 0)
				quantity = Quantity;
			else
				quantity = length;
		}

		public function EmitParticle():void
		{
			var particle:FParticle = Recycle(FParticle) as FParticle;
			particle.lifetime = lifetime;

			// Set up velocity
			var v:FVec = new FVec();
			if(maxSpeed.x != minSpeed.x)
				v.x = FMath.Random(minSpeed.x, maxSpeed.x);
			else
				v.x = minSpeed.x;
			if(maxSpeed.y != minSpeed.y)
				v.y = FMath.Random(minSpeed.y, maxSpeed.y);
			else
				v.y = minSpeed.y;
			particle.velocity = v;

			// Set particle's range of possible starting speeds
			particle.SetXSpeed(minSpeed.x, maxSpeed.x);
			particle.SetYSpeed(minSpeed.y, maxSpeed.y);

			particle.drag = drag;

			// Set particle's top possible speed
			particle.topSpeed = topSpeed;

			// Set up inital particle rotation and rotation speed
			if(maxRotation != minRotation)
				particle.spin = FMath.Random(minRotation, maxRotation);
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

			// If the func is called twice it won't update twice
			_lastX = x;
			_lastY = y;
		}

		// Place the emitter at the origin of an object
		public function At(o:FObject):void
		{
			x = o.x;
			y = o.y;
		}

		public function SetSize(W:uint = 1, H:uint = 1):void { Width = W; Height = H; }
		public function SetDrag(X:uint = 15, Y:uint = 0):void { drag.x = X; drag.y = Y; }
		public function SetTopSpeed(maxX:int = 25, maxY:int = 25):void { topSpeed.x = maxX; topSpeed.y = maxY; }
		public function SetXSpeed(min:int = -25, max:int = 25):void { minSpeed.x = min; maxSpeed.x = max; }
		public function SetYSpeed(min:int = -25, max:int = 25):void { minSpeed.y = min; maxSpeed.y = max; }
	}
}