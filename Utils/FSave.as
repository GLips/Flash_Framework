package Framework.Utils
{

	import flash.net.SharedObject;

	public class FSave
	{

		public static const savePath:String = "/ironswine/"

		public function FSave()
		{
			trace("Don't instantiate FUtils.FSave.");
		}

		public static function Save(saveData:Array, saveName:String):void
		{
			var obj:SharedObject = SharedObject.getLocal(savePath + saveName);
			obj.data.array = saveData;
			obj.flush();
		}

		public static function Load(saveName:String):Array
		{
			var obj:SharedObject = SharedObject.getLocal(savePath + saveName);

			// Returns null if it doesn't exist.
			return obj.data.array;
		}

		public static function Clear(saveName:String):void
		{
			var obj:SharedObject = SharedObject.getLocal(savePath + saveName);
			//obj.data.array = null;
			obj.clear();
		}
	}
}