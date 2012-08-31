package Framework
{

	public class FScene extends FGroup
	{

		public var zone_BG:FGroup;
		public var zone_Game:FGroup;
		public var zone_GUI:FGroup;

		public function FScene()
		{
			super();
		}

		override public function Create():void
		{
			super.Create();
			
			FG._scene = this;

			zone_BG = new FGroup();
			zone_Game = new FGroup();
			zone_GUI = new FGroup();

			Add(zone_BG);
			Add(zone_Game);
			Add(zone_GUI);
		}

		override public function Remove(o:FObject, Splice:Boolean = false):FObject
		{
			if(o != zone_Game && o != zone_GUI && o != zone_BG)
				return zone_Game.Remove(o, Splice);
			else
				return super.Remove(o, Splice);
		}

		override public function Add(o:FObject):FObject
		{
			if(o != zone_Game && o != zone_GUI && o != zone_BG)
				return zone_Game.Add(o);
			else
				return super.Add(o);
		}

	}
}