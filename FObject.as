package Framework
{
	import flash.display.Sprite;

	public class FObject extends Sprite
	{

		public var thinks:Boolean;	// False
		public var draws:Boolean = true;	// False

		public var exists:Boolean;	// False

		public function FObject()
		{
			super();
			Create();
		}

		private function Create():void
		{
			// Called on creation automatically
		}

		private function Destroy():void
		{
			// Called on object removal from the scene
		}

		public function Think():void
		{
			// Called every frame if thinks == true;
		}

		public function Draw():void
		{
			// Called every frame if visible == true;
		}
	}

}