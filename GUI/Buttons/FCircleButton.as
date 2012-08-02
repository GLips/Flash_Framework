package Framework.GUI.Buttons
{

	import Framework.FG;
	import Framework.GUI.FButton;
	import Framework.Utils.FCollide;
	import Framework.Shapes.FCircle;
	
	public class FCircleButton extends FButton
	{

		public var radius:int;

		protected var offsetX:Number;
		protected var offsetY:Number;

		public function FCircleButton(X:int = 0, Y:int = 0, Label:String = null, OnUp:Function = null)
		{
			super(X, Y, Label, OnUp);
		}

		override public function Create():void
		{
			super.Create();

			label.textColor = 0xFFFFFF;
			label.UpdateFormat();

			radius = label.width/1.33;

			offsetX = label.width/2;
			offsetY = label.height/2;
		}

		override protected function doHitTest():Boolean
		{
			return FCollide.PointInCircle(FG.mouse, new FCircle(x + offsetX, y + offsetY, radius))
		}

		override public function Draw():void
		{
			// Handles setting the default style
			super.Draw();

			graphics.drawCircle(offsetX, offsetY, radius);
			graphics.endFill();
			draws = false;
		}
	}
}