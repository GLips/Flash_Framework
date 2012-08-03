package Framework.GUI.Buttons
{

	import Framework.FG;
	
	import Framework.GUI.FGUI;
	import Framework.GUI.FButton;
	import Framework.GUI.FText;

	import Framework.Utils.FCollide;
	
	import Framework.Shapes.FCircle;
	
	public class FCircleButton extends FButton
	{

		public var radius:int;

		protected var offsetX:Number;
		protected var offsetY:Number;

		public function FCircleButton(X:int = 0, Y:int = 0, Label:String = "", OnUp:Function = null)
		{
			super(X, Y, Label, OnUp);
		}

		override public function Create():void
		{
			super.Create();

			label.textColor = 0xFFFFFF;
			label.textAlign = FText.ALIGN_CENTER;
			label.UpdateFormat();

			radius = label.width/1.33;
		}

		override protected function doHitTest():Boolean
		{
			return FCollide.PointInCircle(pointToCheck, new FCircle(x, y, radius));
		}

		override public function Draw():void
		{
			// Handles setting the default style
			super.Draw();

			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
			draws = false;
		}

		override public function CenterX(offset:int = 0):FGUI
		{
			x = FG.width/2 + offset;
			return this;
		}

		override public function CenterY(offset:int = 0):FGUI
		{
			y = FG.height/2 + offset;
			return this;
		}
	}
}