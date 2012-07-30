package Framework.GUI
{
	import Framework.GUI.FText;
	import Framework.FSprite;

	public class FButton extends FSprite
	{

		private var label:FText;

		public var onUp:Function;
		public var onOver:Function;
		public var onDown:Function;

		public function FButton(X:int = 0, Y:int = 0, Label:String = null, OnUp:Function = null)
		{
			super(X, Y)

			onUp = OnUp;

			label = new FText(0, 0, Label);
			addChild(label);
		}

		override public function Update():void
		{
			if(FG.mouse.justPressed() && FCollide.pointInRect(FG.mouse, this) && onDown != null)
			{
				onDown();
			}
			else if(FG.mouse.justReleased() && onUp != null)
			{
				onUp();
			}
		}
	}

}