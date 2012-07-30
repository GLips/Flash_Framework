package Framework.GUI
{
	import Framework.GUI.FText;
	import Framework.FSprite;
	import Framework.FG;
	import Framework.Utils.FCollide;
	import Framework.Shapes.FRect;

	public class FButton extends FSprite
	{

		private var label:FText;

		public var onUp:Function;
		public var onOver:Function;
		public var onDown:Function;

		public function FButton(X:int = 0, Y:int = 0, Label:String = null, OnUp:Function = null)
		{
			super(X, Y)

			thinks = true;

			onUp = OnUp;

			label = new FText(0, 0, Label);
			addChild(label);
		}

		override public function Update():void
		{
			// Make sure we're in the button's hitbox
			var inBox:Boolean = FCollide.PointInRect(FG.mouse, new FRect(x, y, width, height));

			if(FG.mouse.justPressed() && inBox && onDown != null)
			{
				onDown();
			}
			else if(FG.mouse.justReleased() && inBox && onUp != null)
			{
				onUp();
			}
		}
	}

}