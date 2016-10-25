package com.appodeal.test
{
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import com.appodeal.aneplugin.*;
	import com.appodeal.aneplugin.UserSettings;
	import com.appodeal.aneplugin.constants.Alcohol;
	import com.appodeal.aneplugin.constants.Gender;
	import com.appodeal.aneplugin.constants.Occupation;
	import com.appodeal.aneplugin.constants.Relation;
	import com.appodeal.aneplugin.constants.Smoking;
	
	/**
	 * ...
	 * @author Appodeal
	 */
	[SWF(backgroundColor="0xef3326")]
	public class Main extends Sprite 
	{
		private var appodeal:Appodeal;
		private var userSettings:UserSettings;
		private var initializeButton:NetBtn = new NetBtn("Initialize");
		private var showBannerButton:NetBtn = new NetBtn("Show banner");
		private var hideBannerButton:NetBtn = new NetBtn("Hide banner");
		private var showInterstitialButton:NetBtn = new NetBtn("Show interstitial");
		private var showRewardedVideoButton:NetBtn = new NetBtn("Show rewarded video");
		private var showInterstitialOrVideoButton:NetBtn = new NetBtn("Show interstitial or video");
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// Entry point
			// New to AIR? Please read *carefully* the readme.txt files!
			appodeal = new Appodeal();
			userSettings = new UserSettings();
			createUI();
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
		private function createUI():void{
			
			var buttons:Array = new Array(initializeButton, showBannerButton, hideBannerButton, showInterstitialButton, showRewardedVideoButton, showInterstitialOrVideoButton);
			
			var paddingTop:int = 10;
			var currentY:int = paddingTop;
			for (var i:int = 0; i < buttons.length; i++ ){
				addChild(buttons[i]);
				var center:int = (stage.stageWidth - buttons[i].width) / 2;
				buttons[i].x = center;
				buttons[i].y = currentY;
				currentY = currentY + buttons[i].height + paddingTop;
			}
			
			initializeButton.addEventListener(MouseEvent.CLICK, initialize);
			showBannerButton.addEventListener(MouseEvent.CLICK, showBanner);
			hideBannerButton.addEventListener(MouseEvent.CLICK, hideBanner);
			showInterstitialButton.addEventListener(MouseEvent.CLICK, showInterstitial);
			showRewardedVideoButton.addEventListener(MouseEvent.CLICK, showRewarded);
			showInterstitialOrVideoButton.addEventListener(MouseEvent.CLICK, showInterstitialOrVideo);
		}
		
		private function initialize(event:MouseEvent):void{
			//Setting user data
			userSettings.setAge(25);
            userSettings.setAlcohol(Alcohol.NEUTRAL);
            userSettings.setBirthday("01/01/1990");
            userSettings.setEmail("hi@appodeal.com");
            userSettings.setGender(Gender.MALE);
            userSettings.setInterests("gym, cinema, cars, games, tvshows");
            userSettings.setOccupation(Occupation.WORK);
            userSettings.setRelationship(Relation.DATING);
            userSettings.setSmoking(Smoking.NEUTRAL);
            userSettings.setUserId("custom_user_id");
			
			appodeal.setLogging(true);
			appodeal.set728x90Banners(false);
            appodeal.setSmartBanners(false);
            appodeal.setBannerAnimation(false);
            appodeal.setBannerBackground(true);
			
			appodeal.initialize("fee50c333ff3825fd6ad6d38cff78154de3025546d47a84f", AdType.BANNER | AdType.INTERSTITIAL | AdType.REWARDED_VIDEO | AdType.SKIPPABLE_VIDEO);
			
			appodeal.addEventListener(AdEvent.INTERSTITIAL_LOADED, onInterstitial);
            appodeal.addEventListener(AdEvent.INTERSTITIAL_FAILED_TO_LOAD, onInterstitial);
            appodeal.addEventListener(AdEvent.INTERSTITIAL_SHOWN, onInterstitial);
            appodeal.addEventListener(AdEvent.INTERSTITIAL_CLICKED, onInterstitial);
            appodeal.addEventListener(AdEvent.INTERSTITIAL_CLOSED, onInterstitial);
            appodeal.addEventListener(AdEvent.REWARDED_VIDEO_LOADED, onRewardedVideo);
            appodeal.addEventListener(AdEvent.REWARDED_VIDEO_FAILED_TO_LOAD, onRewardedVideo);
            appodeal.addEventListener(AdEvent.REWARDED_VIDEO_SHOWN, onRewardedVideo);
            appodeal.addEventListener(AdEvent.REWARDED_VIDEO_FINISHED, onRewardedVideo);
            appodeal.addEventListener(AdEvent.REWARDED_VIDEO_CLOSED, onRewardedVideo);
            appodeal.addEventListener(AdEvent.SKIPPABLE_VIDEO_LOADED, onSkippableVideo);
            appodeal.addEventListener(AdEvent.SKIPPABLE_VIDEO_FAILED_TO_LOAD, onSkippableVideo);
            appodeal.addEventListener(AdEvent.SKIPPABLE_VIDEO_SHOWN, onSkippableVideo);
            appodeal.addEventListener(AdEvent.SKIPPABLE_VIDEO_CLOSED, onSkippableVideo);
            appodeal.addEventListener(AdEvent.SKIPPABLE_VIDEO_FINISHED, onSkippableVideo);
            appodeal.addEventListener(AdEvent.BANNER_LOADED, onBanner);
            appodeal.addEventListener(AdEvent.BANNER_FAILED_TO_LOAD, onBanner);
            appodeal.addEventListener(AdEvent.BANNER_SHOWN, onBanner);
            appodeal.addEventListener(AdEvent.BANNER_CLICKED, onBanner);
		}
		
		private function showBanner(event:MouseEvent):void{
			appodeal.show(AdType.BANNER_BOTTOM);
		}
		
		private function hideBanner(event:MouseEvent):void{
			appodeal.hide(AdType.BANNER)
		}
		
		private function showInterstitial(event:MouseEvent):void{
			appodeal.show(AdType.INTERSTITIAL);
		}
		
		private function showRewarded(event:MouseEvent):void{
			appodeal.show(AdType.REWARDED_VIDEO);
		}
		
		private function showInterstitialOrVideo(event:MouseEvent):void{
			appodeal.show(AdType.INTERSTITIAL | AdType.SKIPPABLE_VIDEO);
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
        private function onSkippableVideo(event:AdEvent):void
        {
            switch (event.type) {
                case AdEvent.SKIPPABLE_VIDEO_LOADED:
                    trace('onSkippableVideo: ad loaded');
                    break;
                case AdEvent.SKIPPABLE_VIDEO_FAILED_TO_LOAD:
                    trace('onSkippableVideo: failed to load ad');
                    break;
                case AdEvent.SKIPPABLE_VIDEO_SHOWN:
                    trace('onSkippableVideo: ad shown');
                    break;
                case AdEvent.SKIPPABLE_VIDEO_FINISHED:
                    trace('onSkippableVideo: ad clicked, your reward:', event.amount, event.name);
                    break;
                case AdEvent.SKIPPABLE_VIDEO_CLOSED:
                    trace('onSkippableVideo: ad closed');
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
                    trace('onInterstitial: ad loaded');
                    break;
                case AdEvent.INTERSTITIAL_FAILED_TO_LOAD:
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
            }
        }
		
	}
	
}