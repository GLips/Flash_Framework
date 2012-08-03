package Framework.GUI.Buttons
{

	import Framework.FG;
	
	import Framework.GUI.FGUI;
	import Framework.GUI.FButton;
	import Framework.GUI.FText;

	import Framework.Utils.FCollide;
	
	import Framework.Shapes.FRect;
	
	public class FRectButton extends FButton
	{

		protected var offsetX:Number;
		protected var offsetY:Number;

		public var Width:int;
		public var Height:int;

		public function FRectButton(X:int = 0, Y:int = 0, W:int = 0, H:int = 0, Label:String = "", OnUp:Function = null)
		{
			Width = W;
			Height = H;
			super(X, Y, Label, OnUp);
		}

		override public function Create():void
		{
			super.Create();

			label.textColor = 0xFFFFFF;
			label.textAlign = FText.ALIGN_CENTER;
			label.UpdateFormat();
		}

		override public function Draw():void
		{
			// Handles setting the default style
			super.Draw();

			graphics.drawRect(0, 0, Width, Height);
			graphics.endFill();
			draws = false;
		}
	}
}