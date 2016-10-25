package com.appodeal.test 
{
	//Button for transition triggers
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.display.Shape;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	public class NetBtn extends SimpleButton
	{
		public function NetBtn (txt:String)
		{
			upState = new BtnState(0xffffff, 0xffffff,txt);
			downState = new BtnState(0xef3326,0xffffff, txt);
			overState= new BtnState (0xffffff,0xffffff,txt);
			hitTestState=upState;
		}
	}
}