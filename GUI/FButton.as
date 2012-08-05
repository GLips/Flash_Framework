package Framework.GUI
{
	import Framework.GUI.FText;
	import Framework.FSprite;
	import Framework.FG;
	import Framework.Utils.FCollide;
	import Framework.Shapes.FRect;
	import Framework.Maths.FPoint;

	public class FButton extends FGUI
	{

		protected var label:FText;

		public var onUp:Function;
		public var onOver:Function;
		public var onDown:Function;

		// Defaults to FG.mouse
		public var pointToCheck:FPoint;

		// State tracking
		private var lastState:int;
		private var state:int;
		private const DOWN:int 		= 1;
		private const OVER:int 		= 2;
		private const NORMAL:int	= 3;

		// Drawing style
		public var _bgColor:Number;
		public function get bgColor():Number { return _bgColor; }
		// Automatically redraw when background color is changed
		public function set bgColor(x:Number):void { _bgColor = x; draws = true; }

		// Over function trigger
		private var triggered:Boolean;

		public function FButton(X:int = 0, Y:int = 0, Label:String = "", OnUp:Function = null)
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
			pointToCheck = FG.mouse;
		}

		override public function Destroy():void
		{
			pointToCheck = null;
			label = null;
			onUp = null;
			onDown = null;
			onOver = null;

			super.Destroy();
		}

		override public function Update():void
		{
			// Make sure we're in the button's hitbox
			var isColliding:Boolean = doHitTest();

			if(isColliding)
			{
				if(FG.mouse.isDown() && state != DOWN)
				{
					state = DOWN;
					draws = true;
				}
				else if(state != OVER)
				{
					state = OVER;
					draws = true;
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
				if(state != NORMAL)
				{
					state = NORMAL;
					draws = true;
				}

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
			return FCollide.PointInRect(pointToCheck, new FRect(x, y, width, height));
		}
	}

}