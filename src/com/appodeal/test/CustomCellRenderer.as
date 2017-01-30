package com.appodeal.test 
{
	import flash.text.TextFormat;
	import fl.controls.listClasses.CellRenderer;
	import flash.filters.BevelFilter; 
	public class CustomCellRenderer extends CellRenderer
	{

		public function CustomCellRenderer()
		{
			super();
			var tf:TextFormat = new TextFormat();
			tf.size = 30;
			tf.font = "Arial";
			setStyle("embedFonts", true);
			setStyle("textFormat", tf);
			//this.filters = [new BevelFilter()]; 
		}

	}

}