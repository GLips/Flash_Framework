package Framework.GUI
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;

	import Framework.FObject;

	public class FText extends FObject
	{

		public var label:String;
		private var field:TextField;
		public var tFormat:TextFormat;

		public var size:int = 14;

		/*[Embed(systemFont="Arial", 
			fontName = "arial", 
			mimeType = "application/x-font", 
			fontWeight="normal", 
			fontStyle="normal", 
			advancedAntiAliasing="true", 
			embedAsCFF="false")]
		private var defaultFont:Class;*/

		// If set, overrides use of defaultFont
		//public var font:Class;

		// Default color == BLACK
		public var textColor:Number;

		// Tracks if text is on stage already
		private var staged:Boolean;

		public function FText(X:int = 0, Y:int = 0, Label:String = "")
		{
			label = Label;
			textColor = 0x000000;
			super(X, Y);
		}

		override public function Create():void
		{
			UpdateFormat();

			width = field.width;
			height = field.height;
		}

		public function UpdateText(s:String):void
		{
			label = s;
			field.text = s;
		}

		public function UpdateFormat():void
		{
			tFormat = new TextFormat();
			tFormat.size = size;

			if(staged)
			{
				removeChild(field);
				staged = false;
			}

			field = new TextField();
			field.defaultTextFormat = tFormat;
			field.selectable = false;
			field.text = label;
			field.textColor = textColor;
			//field.border = false;		// Redundant
			field.x = 0;
			field.y = 0;
			field.autoSize = TextFieldAutoSize.LEFT;
			field.multiline = false;
			field.wordWrap = false;

			addChild(field);
			staged = true;

			field.defaultTextFormat = tFormat;
			field.text = field.text;
		}
	}

}