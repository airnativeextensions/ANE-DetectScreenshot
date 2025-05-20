/**
 * @author 		Michael Archbold (https://github.com/marchbold)
 * @created		12/03/2025
 */
package com.distriqt.test.detectscreenshot
{
	import feathers.controls.Button;
	import feathers.controls.ScrollContainer;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.themes.MetalWorksMobileTheme;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.Color;

	/**
	 *
	 */
	public class Main extends Sprite implements ILogger
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//


		////////////////////////////////////////////////////////
		//	VARIABLES
		//

		private var _tests:DetectScreenshotTests;

		private var _text:TextField;
		private var _container:ScrollContainer;


		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//


		/**
		 *  Constructor
		 */
		public function Main()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}


		public function log( tag:String, message:String ):void
		{
			trace( tag + "::" + message );
			if (_text)
				_text.text = tag + "::" + message + "\n" + _text.text;
		}


		////////////////////////////////////////////////////////
		//	INTERNALS
		//


		private function createUI():void
		{
			var tf:TextFormat = new TextFormat( "_typewriter", 12, Color.WHITE, HorizontalAlign.LEFT, VerticalAlign.TOP );
			_text = new TextField( stage.stageWidth, stage.stageHeight, "", tf );
			_text.y = 40;
			_text.touchable = false;

			var layout:VerticalLayout = new VerticalLayout();
			layout.horizontalAlign = HorizontalAlign.RIGHT;
			layout.verticalAlign = VerticalAlign.BOTTOM;
			layout.gap = 5;

			_container = new ScrollContainer();
			_container.y = 40;
			_container.layout = layout;
			_container.width = stage.stageWidth;
			_container.height = stage.stageHeight - 80;


			_tests = new DetectScreenshotTests( this );

			addAction( "Check Auth", _tests.checkAuth );
			addAction( "Start", _tests.start );
			addAction( "Stop", _tests.stop );


			addChild( _tests );
			addChild( _text );
			addChild( _container );
		}


		private function addAction( label:String, listener:Function ):void
		{
			var b:Button = new Button();
			b.label = label;
			b.addEventListener( Event.TRIGGERED, listener );
			_container.addChild( b );
		}


		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//

		protected function addedToStageHandler( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			new MetalWorksMobileTheme();
			createUI();
		}


	}
}