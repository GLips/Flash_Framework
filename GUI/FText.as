package Framework.GUI
{
	import flash.text.TextField;
	import flash.text.TextFieldType;

	import Framework.FObject;

	public class FText extends FObject
	{

		public var label:String;
		private var field:TextField;

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

			field = new TextField();
			field.text = label;
			field.type = TextFieldType.DYNAMIC;
			field.border = false;
			field.x = 0;
			field.y = 0;
			field.multiline = true;
			field.wordWrap = true;
			addChild(field);

			trace("New FText instantiated.");
		}
	}

}