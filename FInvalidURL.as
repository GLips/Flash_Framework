package Framework
{

	import Framework.FG;
	import Framework.Utils.FInternet;

	import Framework.GUI.Buttons.FRectButton;
	import Framework.GUI.FText;

	public class FInvalidURL extends FScene
	{
		public function FInvalidURL():void
		{
			super();
		}

		override public function Create():void
		{
			super.Create();

			var b:FRectButton = new FRectButton(0, 0, 150, 40, "Play " + FG.gameName, goToGame);
			b.CenterX().CenterY();
			Add(b);

			var t:FText = new FText(0, 0, "Hey! It looks like somebody copied this game without my permission.  Click the button below to go to \n\n"+FG.gameURL+"\n\nand play the game at my site.  Thanks, and have fun!");
			t.textAlign = FText.ALIGN_CENTER;
			t.UpdateFormat();
			t.CenterX().CenterY(-100);
			Add(t);

			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, FG.width, FG.height);
			graphics.endFill();
		}

		private function goToGame():void
		{
			FInternet.GoToURL("http://"+FG.gameURL);
		}
	}
}