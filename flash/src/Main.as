package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import game.Game;
	import starling.core.Starling;

	/**
	 * ...
	 * @author hlavko
	 */
	public class Main extends Sprite {
		
		private var _starling:Starling;

		public function Main():void {
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initStarling();
		}
		
		private function initStarling():void {
			this.scaleY = this.scaleX = 1 / Starling.contentScaleFactor;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;	
		
			Starling.handleLostContext = true;
			
			_starling = new Starling(Game, stage, null, null, "auto");
				
			//_starling.enableErrorChecking = true;
			_starling.showStats = true;
			_starling.start();
		}

	}

}