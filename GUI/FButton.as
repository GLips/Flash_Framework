package Framework.GUI
{
	import Framework.GUI.FText;
	import Framework.FSprite;
	import Framework.FG;
	import Framework.Util.FCollide;
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

			onUp = OnUp;

			label = new FText(0, 0, Label);
			addChild(label);
		}

		override public function Update():void
		{
			if(FG.mouse.justPressed())
			{
				trace("just pressed");
			}
			if(FG.mouse.justPressed() && FCollide.PointInRect(FG.mouse, new FRect(x, y, width, height)) && onDown != null)
			{
				trace("onDown");
				onDown();
			}
			else if(FG.mouse.justReleased() && FCollide.PointInRect(FG.mouse, new FRect(x, y, width, height)) && onUp != null)
			{
				trace("onUp");
				onUp();
			}
		}
	}

}