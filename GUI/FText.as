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
		public var font:Class;

		public function FText(X:int = 0, Y:int = 0, Label:String = null)
		{
			super(X, Y);
			label = Label;

			tFormat = new TextFormat();
			tFormat.size = size;

			field = new TextField();
			field.defaultTextFormat = tFormat;
			field.text = label;
			field.type = TextFieldType.INPUT;
			field.border = false;
			field.x = 0;
			field.y = 0;
			field.autoSize = TextFieldAutoSize.LEFT;
			field.multiline = false;
			field.wordWrap = false;
			addChild(field);

			width = field.width;
			height = field.height;
		}
	}

}