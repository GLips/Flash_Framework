package Framework.GUI
{
	import Framework.GUI.FText;
	import Framework.FSprite;

	public class FButton extends FSprite
	{

		private var label:FText;

		public function FButton(X:int = 0, Y:int = 0, Label:String = null, OnClick:Function = null)
		{
			super(X, Y)
			label = new FText(0, 0, Label);
			addChild(label);
		}
	}

}