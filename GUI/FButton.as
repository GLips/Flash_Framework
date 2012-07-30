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

		// State tracking
		private var lastState:int;
		private var state:int;
		private const DOWN:int 		= 1;
		private const OVER:int 		= 2;
		private const NORMAL:int	= 3;

		// Over function trigger
		private var triggered:Boolean;

		public function FButton(X:int = 0, Y:int = 0, Label:String = null, OnUp:Function = null)
		{
			super(X, Y)

			thinks = true;

			state = NORMAL;

			onUp = OnUp;

			label = new FText(0, 0, Label);
			addChild(label);
		}

		override public function Update():void
		{
			// Make sure we're in the button's hitbox
			var inBox:Boolean = FCollide.PointInRect(FG.mouse, new FRect(x, y, width, height));

			if(inBox)
			{
				if(FG.mouse.isDown())
				{
					state = DOWN;
				}
				else
				{
					state = OVER;
				}
				
				// Make sure we only trigger the roll over func once per roll
				if(!triggered && onOver != null)
				{
					triggered = true;
					onOver();
				}

				if(FG.mouse.justPressed() && onDown != null)
				{
					onDown();
				}
				else if(FG.mouse.justReleased() && onUp != null)
				{
					onUp();
				}
			}
			else
			{
				state = NORMAL;

				// Reset the over trigger
				if(triggered)
				{
					triggered = false;
				}
			}
		}
	}

}