package com.appodeal.test
{
	import fl.data.DataProvider;
	import flash.desktop.InteractiveIcon;
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import com.appodeal.aneplugin.*;
	import com.appodeal.aneplugin.UserSettings;
	import com.appodeal.aneplugin.constants.*;
	
	import fl.controls.Button;
	import fl.controls.ComboBox;
	import fl.controls.CheckBox;
	/**
	 * ...
	 * @author Appodeal
	 */
	[SWF(backgroundColor="0xef3326")]
	public class Main extends Sprite 
	{
		private static const STAGE_WIDTH:int = 480;
        private static const STAGE_HEIGHT:int = 320;
		private static const BUTTON_WIDTH:int = 190;
		private static const BUTTON_HEIGHT:int = 30;
		private static const PADDING:int = 5;
		
		private var appodeal:Appodeal;
		private var userSettings:UserSettings;
		
		private var adType:ComboBox = new ComboBox();
		private var initializeButton:Button = new Button();
		private var cacheButton:Button = new Button();
		private var isLoadedButton:Button = new Button();
		private var isPrecacheButton:Button = new Button();
		private var showButton:Button = new Button();
		private var showWithPlacementButton:Button = new Button();
		private var hideButton:Button = new Button();
		
		private var loggingCb:CheckBox = new CheckBox();
		private var testingCb:CheckBox = new CheckBox();
		private var autocacheCb:CheckBox = new CheckBox();
		private var disableSmartBannersCb:CheckBox = new CheckBox();
		private var disableBannerAnimationCb:CheckBox = new CheckBox();
		private var disable728x90BannersCb:CheckBox = new CheckBox();
		private var enableTriggerOnLoadedOnPrecacheCb:CheckBox = new CheckBox();
		private var disableLocationPermissionCheckCb:CheckBox = new CheckBox();
		private var disableWriteExternalStorageCheckCb:CheckBox = new CheckBox();
		
		[Embed(source="arial.ttf",
        fontName = "Arial",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF = "false")]
		private var myFont:Class;
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// Entry point
			// New to AIR? Please read *carefully* the readme.txt files!
			appodeal = new Appodeal();
			userSettings = new UserSettings();
			trace("Appodeal. main finished");
			createUI();
			width = STAGE_WIDTH;
			height = STAGE_HEIGHT;
			stage.addEventListener(Event.RESIZE, stageResize);
			//x = -(stageWidth - width) / 2;
		}
		
		public function stageResize(event:Event):void {   
			trace("Appodeal. sWidth: " + stage.stageWidth);
			trace("Apodeal. sHeight: " + stage.stageHeight);
			var stageWidth:int = stage.fullScreenWidth;
			var stageHeight:int = stage.fullScreenHeight;
			scaleX = stageWidth / STAGE_WIDTH;
			scaleY = stageHeight / STAGE_HEIGHT;
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
		private function createUI():void{
			
			var buttons:Array = new Array(adType, initializeButton, cacheButton, isLoadedButton, isPrecacheButton, showButton, showWithPlacementButton, hideButton);
			
			var tf:TextFormat = new TextFormat();
			tf.font = "Arial";
			tf.size = 18;
			tf.color = 0x000000;
			var currentY:int = PADDING;
			
			adType.prompt = "Select Ad Typle";
			var types:Array = new Array("Banner", "Banner Top", "Banner Bottom", "Interstitial", "Rewarded Video");
			adType.dataProvider = new DataProvider(types);
			adType.dropdown.setStyle("cellRenderer", CustomCellRenderer);
			adType.dropdown.rowHeight = 50;
			adType.dropdownWidth = 400;
			adType.dropdown.invalidateList();
			adType.dropdown.invalidate();
			//adType.selectedIndex;
			
			var xPos:int = PADDING;
			var i:int;
			for( i = 0; i < buttons.length; i++ ){
				addChild(buttons[i]);
				buttons[i].setSize(BUTTON_WIDTH, BUTTON_HEIGHT);
				buttons[i].setStyle("textFormat", tf);
				buttons[i].move(xPos, currentY);
				currentY = currentY + buttons[i].height + PADDING;
			}
			
			initializeButton.label = "Initialize";
			cacheButton.label = "Cache";
			isLoadedButton.label = "Is Loaded?";
			isPrecacheButton.label = "Is Precache?";
			showButton.label = "Show";
			showWithPlacementButton.label = "Show With Placement";
			hideButton.label = "Hide";
			
			loggingCb.label = "Logging";
			testingCb.label = "Testing";
			autocacheCb.label = "AutoCache";
			disableSmartBannersCb.label = "Disable Smart Banners";
			disableBannerAnimationCb.label = "Disable Banner Animation";
			disable728x90BannersCb.label = "Disable 728x90 Banners";
			enableTriggerOnLoadedOnPrecacheCb.label = "Enable Trigger onLoaded on Precache";
			disableLocationPermissionCheckCb.label = "Disable Location Permission Check";
			disableWriteExternalStorageCheckCb.label = "Disable Write External Storage Check";
			
			var checkboxes:Array = new Array(loggingCb, testingCb, autocacheCb, disableSmartBannersCb, disableBannerAnimationCb, disable728x90BannersCb, enableTriggerOnLoadedOnPrecacheCb, disableLocationPermissionCheckCb, disableWriteExternalStorageCheckCb);
			currentY = PADDING;
			var leftColumn:int = PADDING * 2 + BUTTON_WIDTH;
			xPos = leftColumn;
			var lastDouble:int = 1;
			tf.size = 15;
			for(i = 0; i < checkboxes.length; i++ ){
				addChild(checkboxes[i]);
				var width:int = STAGE_WIDTH - leftColumn - 2 * PADDING;
				if (i <= lastDouble) width = width / 2;
				checkboxes[i].setSize(width, BUTTON_HEIGHT);
				checkboxes[i].setStyle("textFormat", tf);
				checkboxes[i].move(xPos, currentY);
				if (i > lastDouble)
				{
					currentY = currentY + checkboxes[i].height + PADDING;
					xPos = leftColumn;
				}
				else{
					if (xPos > leftColumn){
						xPos = leftColumn;
						trace("Appodeal. 1. xPos: ", xPos);
						currentY = currentY + checkboxes[i].height + PADDING;
					}
					else
					{
						xPos = xPos + PADDING + width;
						trace("Appodeal. 2. xPos: ", xPos);
					}
				}
			}
			
			//Cb.selected;
			
			initializeButton.addEventListener(MouseEvent.CLICK, initialize);
			cacheButton.addEventListener(MouseEvent.CLICK, cache);
			isLoadedButton.addEventListener(MouseEvent.CLICK, isLoaded);
			isPrecacheButton.addEventListener(MouseEvent.CLICK, isPrecache);
			showButton.addEventListener(MouseEvent.CLICK, show);
			showWithPlacementButton.addEventListener(MouseEvent.CLICK, showWithPlacement);
			hideButton.addEventListener(MouseEvent.CLICK, hide);
		}
		
		private function initialize(event:MouseEvent):void{
			if (loggingCb.selected) appodeal.setLogLevel(LogLevel.VERBOSE);
			else appodeal.setLogLevel(LogLevel.NONE);
			appodeal.setTesting(testingCb.selected);
			
			//Setting user data
			userSettings.setAge(25);
            userSettings.setGender(Gender.MALE);
            userSettings.setUserId("custom_user_id");
			
			appodeal.setTabletBanners(!disable728x90BannersCb.selected);
            appodeal.setSmartBanners(!disableSmartBannersCb.selected);
            appodeal.setBannerAnimation(!disableBannerAnimationCb.selected);
			appodeal.setTriggerOnLoadedOnPrecache(getSelectedAdType(), enableTriggerOnLoadedOnPrecacheCb.selected);
			if (disableLocationPermissionCheckCb.selected)
				appodeal.disableLocationPermissionCheck();
			if (disableWriteExternalStorageCheckCb.selected)
				appodeal.disableWriteExternalStoragePermissionCheck();
			
			appodeal.setAutoCache(getSelectedAdType(), autocacheCb.selected);
			
			appodeal.initialize("fee50c333ff3825fd6ad6d38cff78154de3025546d47a84f", getSelectedAdType());
			
			appodeal.addEventListener(AdEvent.INTERSTITIAL_LOADED, onInterstitial);
            appodeal.addEventListener(AdEvent.INTERSTITIAL_FAILED_TO_LOAD, onInterstitial);
            appodeal.addEventListener(AdEvent.INTERSTITIAL_SHOWN, onInterstitial);
            appodeal.addEventListener(AdEvent.INTERSTITIAL_CLICKED, onInterstitial);
            appodeal.addEventListener(AdEvent.INTERSTITIAL_CLOSED, onInterstitial);
			appodeal.addEventListener(AdEvent.INTERSTITIAL_FINISHED, onInterstitial);
            appodeal.addEventListener(AdEvent.REWARDED_VIDEO_LOADED, onRewardedVideo);
            appodeal.addEventListener(AdEvent.REWARDED_VIDEO_FAILED_TO_LOAD, onRewardedVideo);
            appodeal.addEventListener(AdEvent.REWARDED_VIDEO_SHOWN, onRewardedVideo);
            appodeal.addEventListener(AdEvent.REWARDED_VIDEO_FINISHED, onRewardedVideo);
            appodeal.addEventListener(AdEvent.REWARDED_VIDEO_CLOSED, onRewardedVideo);
            appodeal.addEventListener(AdEvent.BANNER_LOADED, onBanner);
            appodeal.addEventListener(AdEvent.BANNER_FAILED_TO_LOAD, onBanner);
            appodeal.addEventListener(AdEvent.BANNER_SHOWN, onBanner);
            appodeal.addEventListener(AdEvent.BANNER_CLICKED, onBanner);
		}
		
		private function getSelectedAdType():int{
			switch( adType.selectedIndex ){
				case 0:
					return AdType.BANNER;
				case 1:
					return AdType.BANNER_TOP;
				case 2:
					return AdType.BANNER_BOTTOM;
				case 3:
					return AdType.INTERSTITIAL;
				case 4:
					return AdType.REWARDED_VIDEO;
				default:
					return 0;
			}
			
		}
		
		private function cache(event:MouseEvent):void{
			appodeal.cache(getSelectedAdType());
		}
		
		private function isLoaded(event:MouseEvent):void{
			trace("is loaded: ", appodeal.isLoaded(getSelectedAdType()));
		}
		
		private function isPrecache(event:MouseEvent):void{
			trace("is precache: ", appodeal.isPrecache(getSelectedAdType()));
		}
		
		private function show(event:MouseEvent):void{
			appodeal.show(getSelectedAdType());
		}
		
		private function showWithPlacement(event:MouseEvent):void{
			appodeal.showWithPlacement(getSelectedAdType(), "main_menu");
		}
		
		private function hide(event:MouseEvent):void{
			appodeal.hide(getSelectedAdType());
		}
		
		private function onNonSkippableVideo(event:AdEvent):void
        {
            switch (event.type) {
                case AdEvent.NON_SKIPPABLE_VIDEO_LOADED:
                    trace('onNonSkippableVideo: ad loaded');
                    break;
                case AdEvent.NON_SKIPPABLE_VIDEO_FAILED_TO_LOAD:
                    trace('onNonSkippableVideo: failed to load ad');
                    break;
                case AdEvent.NON_SKIPPABLE_VIDEO_SHOWN:
                    trace('onNonSkippableVideo: ad shown');
                    break;
                case AdEvent.NON_SKIPPABLE_VIDEO_FINISHED:
                    trace('onNonSkippableVideo: ad clicked, your reward:', event.amount, event.name);
                    break;
                case AdEvent.NON_SKIPPABLE_VIDEO_CLOSED:
                    trace('onNonSkippableVideo: ad closed');
                    break;
            }
        }
        private function onBanner(event:AdEvent):void
        {
            switch (event.type) {
                case AdEvent.BANNER_LOADED:
                    trace('onBanner:ad loaded');
                    break;
                case AdEvent.BANNER_FAILED_TO_LOAD:
                    trace('onBanner: failed to load ad');
                    break;
                case AdEvent.BANNER_SHOWN:
                    trace('onBanner: ad shown');
                    break;
                case AdEvent.BANNER_CLICKED:
                    trace('onBanner: ad clicked');
                    break;
            }
        }
        private function onRewardedVideo(event:AdEvent):void
        {
            switch (event.type) {
                case AdEvent.REWARDED_VIDEO_LOADED:
                    trace('onRewardedVideo: ad loaded');
                    break;
                case AdEvent.REWARDED_VIDEO_FAILED_TO_LOAD:
                    trace('onRewardedVideo: failed to load ad');
                    break;
                case AdEvent.REWARDED_VIDEO_SHOWN:
                    trace('onRewardedVideo: ad shown');
                    break;
                case AdEvent.REWARDED_VIDEO_FINISHED:
                    videoShown = false;
                    trace('onRewardedVideo: ad clicked, your reward:', event.amount, event.name);
                    break;
                case AdEvent.REWARDED_VIDEO_CLOSED:
                    trace('onRewardedVideo: ad closed');
                    break;
            }
        }
        private function onInterstitial(event:AdEvent):void
        {
            switch (event.type) {
                case AdEvent.INTERSTITIAL_LOADED:
					interstitialState = 2;
                    trace('onInterstitial: ad loaded');
                    break;
                case AdEvent.INTERSTITIAL_FAILED_TO_LOAD:
					interstitialState = 0;
                    trace('onInterstitial: failed to load ad');
                    break;
                case AdEvent.INTERSTITIAL_SHOWN:
                    trace('onInterstitial: ad shown');
                    break;
                case AdEvent.INTERSTITIAL_CLICKED:
                    trace('onInterstitial: ad has clicked');
                    break;
                case AdEvent.INTERSTITIAL_CLOSED:
                    trace('onInterstitial: ad closed');
                    break;
				case AdEvent.INTERSTITIAL_FINISHED:
					trace('onInterstitial: ad finished');
					appodeal.toast('onInterstitial: ad finished');
					break;
            }
        }
	}
	
}