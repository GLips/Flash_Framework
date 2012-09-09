package Framework.Utils
{
	import flash.display.Sprite;
	import flash.display.LoaderInfo;

	import Framework.FG;

	public class FInternet
	{
		public function FInternet()
		{
			trace("Don't instantiate Utils.FInternet.");
		}

		public static function GetCurrentURL(ref:Sprite):String
		{
			var cur_url:String = GetMainLoaderInfo(ref).url;

			// No need to return the full local path, just tell us it's local
			var ind:int = cur_url.indexOf("file://");
			if(ind != -1)
				cur_url = "local";

			return cur_url;
		}

		public static function GetMainLoaderInfo(ref:Sprite):LoaderInfo {
            var loaderInfo:LoaderInfo = ref.root.loaderInfo;
            while (loaderInfo.loader != null) {
                loaderInfo = loaderInfo.loader.loaderInfo;
            }
            return loaderInfo;
        }

		public static function ValidURL(ref:Sprite, comparison:String, allowLocal:Boolean=false):Boolean
		{	
			var cur_url:String = GetCurrentURL(ref);
			
			if(cur_url == "local")
			{
				if(allowLocal)
					return true;
			}
			else
			{
				var dmn:String = cur_url.split("/")[2];        //This is the part of the string after the "http://"
				var dmn_ind:int = dmn.indexOf(comparison);
				if( (dmn_ind != -1) && (dmn_ind == (dmn.length - comparison.length)) )
					return true
			}
			return false;
		}

		public static function GoToURL(url:String):void
		{

		}
	}
}