package Framework
{

	import flash.events.*;

	import flash.utils.getTimer;
	import flash.utils.getDefinitionByName;

	import flash.net.navigateToURL;
	import flash.net.URLRequest;

	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Graphics;
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.StageScaleMode;

	import Framework.FG;

	public class FPreloader extends MovieClip
	{

		// Minimum time to display preloader
		public var _min:Number;

		// If the preloader has been initialized
		public var _init:Boolean;

		public var _buffer:Sprite;
		public var _bar:Sprite;

		public var _width:int;
		public var _height:int;

		public var className:String;

		[Embed(source="./Media/Images/peeg.png")]
		//[Embed(source="./Media/Images/sponsors.png")]
        public var i_peeg:Class;
        public var peeg:Bitmap;

		public function FPreloader()
		{
			stop();

			stage.scaleMode = StageScaleMode.NO_SCALE;
		
			_min = 1;
			_init = false;
		
			addEventListener(Event.ENTER_FRAME, Update);
		}

		public function Create():void
		{
			_init = true;

			_width = stage.stageWidth;
			_height = stage.stageHeight;
		
			_buffer = new Sprite();
			_buffer.graphics.beginFill(0xCCCCCC);
			_buffer.graphics.drawRect(0, 0, _width, _height);
			_buffer.graphics.endFill();	
			addChild(_buffer);

			_bar = new Sprite();
			_buffer.addChild(_bar);

			peeg = new i_peeg();
			peeg.x = _width/2 - peeg.width/2;
			peeg.y = _height/2 - peeg.height/2;
			_buffer.addChild(peeg);

			var bitmap:Bitmap = new Bitmap(new BitmapData(_width,_height,false,0xffffff));
			var i:uint = 0;
			var j:uint = 0;
			while(i < _height)
			{
				j = 0;
				while(j < _width)
					bitmap.bitmapData.setPixel(j++,i,0);
				i+=2;
			}
			bitmap.blendMode = "overlay";
			bitmap.alpha = 0.25;
			_buffer.addChild(bitmap);
		}

		public function Destroy():void
		{
			removeChild(_buffer);
		}

		public function Update(e:Event):void
		{
			if(!_init)
				Create();

			var time:Number = getTimer()/1000;
			var percent:Number = root.loaderInfo.bytesLoaded/root.loaderInfo.bytesTotal;

			// If loading is faster than we want to display the loader for, artifically delay it
			if((_min > 0) && (percent > time/_min))
				percent = time/_min;

			if(percent >= 1)
			{
				drawLoadBar(percent);

				removeEventListener(Event.ENTER_FRAME, Update);	
				nextFrame();

				var mainClass:Class = Class(getDefinitionByName(className));
				if(mainClass)
				{
					var app:Object = new mainClass();
					addChild(app as DisplayObject);
				}

				Destroy();
			}
			else
			{
				drawLoadBar(percent);
			}
		}

		protected function drawLoadBar(p:Number):void
		{
			_bar.graphics.clear();
			_bar.graphics.beginFill(0x33CC33);
			_bar.graphics.drawRect(0, _height - 20, _width * p, 20);
			_bar.graphics.endFill();
		}
	}
}