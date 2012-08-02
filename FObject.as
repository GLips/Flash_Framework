package Framework
{
	import flash.display.Sprite;

	public class FObject extends Sprite
	{

		public var thinks:Boolean;	// Set to true
		public var draws:Boolean = true;	// False
		protected var paused:Boolean;		// False

		public var exists:Boolean;	// Set to true

		public function FObject(X:int = 0, Y:int = 0)
		{
			x = X;
			y = Y;
			super();
			Create();
			exists = true;
			thinks = true;
		}

		public function Create():void
		{
			// Called on creation automatically
		}

		public function Destroy():void
		{
			// Called on object removal from the scene
		}

		public function Update():void
		{
			// Called every frame if thinks == true;
		}

		public function Draw():void
		{
			// Called every frame if visible == true;
		}
	}

}