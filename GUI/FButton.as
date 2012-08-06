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

		private var styles:Array;

		// Automatically redraw when background color is changed
		public function setbgColor(x:Number, s:int = NORMAL):void { styles[s]['bgColor'] = x; draws = true; }

		public function get currentStyle():Array
		{ 
			if(styles[state] != null)
				return styles[state];
			else
				return styles[NORMAL];
		}

		// Over function trigger
		private var triggered:Boolean;

		/*******************************
		** 
		** INIT Function
		** 
		********************************/
		public function FButton(X:int = 0, Y:int = 0, Label:String = "", OnUp:Function = null)
		{
			onUp = OnUp;

			label = new FText(0, 0, Label);
			addChild(label);

			super(X, Y);
		}


		/*******************************
		** 
		** CREATE Function
		** 
		********************************/
		override public function Create():void
		{
			styles = new Array();
			state = NORMAL;

			// Initialize styles
			styles[NORMAL] = new Array();
			styles[OVER] = new Array();
			styles[DOWN] = new Array();

			styles[NORMAL]['bgColor'] = 0x0066CC;
			styles[OVER]['bgColor'] = 0x0077DD;
			styles[DOWN]['bgColor'] = 0x0055BB;

			styles[NORMAL]['lineColor'] = 0x0044AA;
			styles[OVER]['lineColor'] = 0x0055BB;
			styles[DOWN]['lineColor'] = 0x003399;

			pointToCheck = FG.mouse;
		}


		/*******************************
		** 
		** DESTROY Function
		** 
		********************************/
		override public function Destroy():void
		{
			pointToCheck = null;
			label = null;
			onUp = null;
			onDown = null;
			onOver = null;

			super.Destroy();
		}


		/*******************************
		** 
		** UPDATE Function
		** 
		********************************/
		override public function Update():void
		{
			// Make sure we're in the button's hitbox
			var isColliding:Boolean = doHitTest();

			if(isColliding)
			{
				if(FG.mouse.isDown() && state != DOWN)
				{
					label.y++;
					state = DOWN;
					draws = true;
				}
				else if(!FG.mouse.isDown() && state != OVER)
				{
					if(state == DOWN)
						label.y--;
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
					if(state == DOWN)
						label.y--;
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
			graphics.lineStyle(1, currentStyle['lineColor']);
			graphics.beginFill(currentStyle['bgColor']);
		}

		protected function doHitTest():Boolean
		{
			return FCollide.PointInRect(pointToCheck, new FRect(x, y, width, height));
		}
	}

}