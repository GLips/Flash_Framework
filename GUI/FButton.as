package Framework.GUI
{
	import Framework.GUI.FText;
	import Framework.FSprite;
	import Framework.FG;
	import Framework.Utils.FCollide;
	import Framework.Shapes.FRect;

	public class FButton extends FSprite
	{

		protected var label:FText;

		public var onUp:Function;
		public var onOver:Function;
		public var onDown:Function;

		// State tracking
		private var lastState:int;
		private var state:int;
		private const DOWN:int 		= 1;
		private const OVER:int 		= 2;
		private const NORMAL:int	= 3;

		// Drawing style
		public var _bgColor:Number;
		public function get bgColor():Number { return _bgColor; }
		public function set bgColor(x:Number):void { _bgColor = x; draws = true; }

		// Over function trigger
		private var triggered:Boolean;

		public function FButton(X:int = 0, Y:int = 0, Label:String = null, OnUp:Function = null)
		{
			onUp = OnUp;

			label = new FText(0, 0, Label);
			addChild(label);

			super(X, Y);
		}
		override public function Create():void
		{
			state = NORMAL;
			bgColor = 0x0066CC;
		}

		override public function Update():void
		{
			// Make sure we're in the button's hitbox
			var isColliding:Boolean = doHitTest();

			if(isColliding)
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

		// Only handles default drawing settings. Use Framework.GUI.Buttons for styled buttons.
		override public function Draw():void
		{
			graphics.clear();
			graphics.beginFill(bgColor);
		}

		protected function doHitTest():Boolean
		{
			return FCollide.PointInRect(FG.mouse, new FRect(x, y, width, height));
		}
	}

}