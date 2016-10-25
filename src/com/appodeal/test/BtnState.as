package com.appodeal.test 
{
	//Create a button that will display states #6
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	public class BtnState extends Sprite
	{
		public var btnLabel:TextField;
		public function BtnState (color:uint,color2:uint,btnLabelText:String)
		{
			btnLabel = new TextField;
			btnLabel.text = btnLabelText;
			btnLabel.x = 5;
			btnLabel.y = 5;
			var format:TextFormat=new TextFormat("Verdana");
			format.size=30;
			btnLabel.setTextFormat (format);
			btnLabel.autoSize = TextFieldAutoSize.LEFT;
			
			var bkground:Shape=new Shape;
			bkground.graphics.beginFill (color);
			bkground.graphics.lineStyle (2,color2);
			bkground.graphics.drawRoundRect (0,0, btnLabel.textWidth + 10, btnLabel.textHeight + 10, 10, 10);
			addChild (bkground);
			addChild (btnLabel);
		}
	}
}