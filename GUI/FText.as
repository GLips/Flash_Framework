package Framework.GUI
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;

	import Framework.GUI.FGUI;

	public class FText extends FGUI
	{

		public var label:String;
		public var field:TextField;
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

		// Alignment stuff
		public static const ALIGN_LEFT:String = TextFieldAutoSize.LEFT;
		public static const ALIGN_RIGHT:String = TextFieldAutoSize.RIGHT;
		public static const ALIGN_CENTER:String = TextFieldAutoSize.CENTER;
		public var textAlign:String;

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
			super.Create();

			textAlign = FText.ALIGN_LEFT;
		
			UpdateFormat();

			width = field.width;
			height = field.height;
		}

		override public function Destroy():void
		{
			super.Destroy();
			field = null;
			tFormat = null;
		}

		public function UpdateText(s:String):FText
		{
			label = s;
			field.text = s;
			return this;
		}

		public function UpdateFormat():FText
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
			field.autoSize = textAlign;
			field.multiline = true;
			field.wordWrap = false;

			addChild(field);
			staged = true;
			return this;
		}

		public function CenterText():FText
		{
			field.x = -field.width/2;
			field.y = -field.height/2;
			return(this);
		}
	}

}