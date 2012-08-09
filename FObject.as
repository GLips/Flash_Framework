package Framework
{
	import flash.display.Sprite;

	public class FObject extends Sprite
	{

		public var thinks:Boolean;			// True
		public var draws:Boolean;			// False
		protected var paused:Boolean;		// False

		public var exists:Boolean;			// True
		public var alive:Boolean;			// True

		public function FObject()
		{
			super();
			Create();
			exists = true;
			thinks = true;
			alive = true;
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

		public function Kill():void
		{
			exists = false;
			alive = false;
		}
	}

}