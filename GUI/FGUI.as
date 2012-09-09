package Framework.GUI
{
	import Framework.FSprite;
	import Framework.FG;

	public class FGUI extends FSprite
	{
		public function FGUI(X:int = 0, Y:int = 0)
		{
			super(X, Y);
		}

		public function CenterX(offset:int = 0):FGUI
		{
			// So we can work with the current width/height
			if(draws)
				Draw();
	
			x = FG.width/2 - width/2 + offset;
			return this;
		}

		public function CenterY(offset:int = 0):FGUI
		{
			// So we can work with the current width/height
			if(draws)
				Draw();

			y = FG.height/2 - height/2 + offset;
			return this;
		}
	}

}