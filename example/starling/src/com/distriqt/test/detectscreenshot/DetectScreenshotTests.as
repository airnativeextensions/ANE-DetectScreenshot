/**
 * @author 		Michael Archbold (https://github.com/marchbold)
 * @created		12/03/2025
 */
package com.distriqt.test.detectscreenshot
{
	import com.distriqt.extension.detectscreenshot.DetectScreenshot;
	import com.distriqt.extension.detectscreenshot.events.DetectScreenshotEvent;
	import com.distriqt.extension.detectscreenshot.AuthorisationStatus;

	import starling.display.Sprite;

	/**
	 */
	public class DetectScreenshotTests extends Sprite
	{
		public static const TAG:String = "";

		private var _l:ILogger;

		private function log( log:String ):void
		{
			_l.log( TAG, log );
		}


		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//

		public function DetectScreenshotTests( logger:ILogger )
		{
			_l = logger;
			try
			{
				log( "DetectScreenshot Supported: " + DetectScreenshot.isSupported );
				if (DetectScreenshot.isSupported)
				{
					log( "DetectScreenshot Version:   " + DetectScreenshot.service.version );
				}

			}
			catch (e:Error)
			{
				trace( e );
			}
		}


		////////////////////////////////////////////////////////
		//  
		//

		public function checkAuth():void
		{
//			var status:String = Permissions.instance.authorisationStatusForPermission( "android.permission.READ_MEDIA_IMAGES" );
//
//			log( "checkAuth: status: " + status );
//
//			switch (status)
//			{
//				case AuthorisationStatus.AUTHORISED:
//					log( "checkAuth: GRANTED" );
//					break;
//
//				case AuthorisationStatus.NOT_DETERMINED:
//				case AuthorisationStatus.DENIED:
//				case AuthorisationStatus.SHOULD_EXPLAIN:
//				case AuthorisationStatus.UNKNOWN:
//				case AuthorisationStatus.RESTRICTED:
//					Permissions.instance.requestAuthorisationForPermission(
//							"android.permission.READ_MEDIA_IMAGES",
//							function ( status:String ):void
//							{
//								log( "requestAuthorisationForPermission(): status=" + status );
//							} );
//					break;
//			}


			var status:String = DetectScreenshot.instance.authorisationStatus();
			log( "checkAuth: status: " + status );
			switch (status)
			{
				case AuthorisationStatus.AUTHORISED:
					log( "checkAuth: GRANTED" );
					break;

				case AuthorisationStatus.NOT_DETERMINED:
				case AuthorisationStatus.DENIED:
				case AuthorisationStatus.SHOULD_EXPLAIN:
				case AuthorisationStatus.UNKNOWN:
				case AuthorisationStatus.RESTRICTED:
					DetectScreenshot.instance.requestAuthorisation(
							function ( status:String ):void
							{
								log( "requestAuthorisation(): status=" + status );
							} );
					break;
			}


		}

		public function start():void
		{
			log( "DetectScreenshotTests.start()" );
			if (DetectScreenshot.isSupported)
			{
				DetectScreenshot.instance.addEventListener( DetectScreenshotEvent.SCREENSHOT_DETECTED, onScreenshotDetected );
				var success:Boolean = DetectScreenshot.instance.start();
				log( "DetectScreenshotTests.start(): " + success );
			}
			else
			{
				log( "DetectScreenshot is not supported" );
			}
		}


		public function stop():void
		{
			log( "DetectScreenshotTests.stop()" );
			if (DetectScreenshot.isSupported)
			{
				DetectScreenshot.instance.removeEventListener( DetectScreenshotEvent.SCREENSHOT_DETECTED, onScreenshotDetected );
				DetectScreenshot.instance.stop();
			}
			else
			{
				log( "DetectScreenshot is not supported" );
			}
		}


		private function onScreenshotDetected( event:DetectScreenshotEvent ):void
		{
			log( "onScreenshotDetected" );
		}

	}
}
