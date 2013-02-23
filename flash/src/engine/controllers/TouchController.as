package engine.controllers {
	
	import engine.components.InputComponent;
	import flash.geom.Point;
	import org.osflash.signals.Signal;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * ...
	 * @author hlavko
	 */
	public class TouchController extends InputComponent {
		
		public var onTouchDown:Signal = new Signal(Point);
		
		private var container:Sprite;

		public function TouchController() {
			super();
		}
		
		override public function start():void {
			container = renderer.getLayer("terrain").getContainer();
			container.touchable = true;
			container.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override public function dispose():void {
			container.removeEventListener(TouchEvent.TOUCH, onTouch);
			super.dispose();
		}
		
		private function onTouch(event:TouchEvent):void {
			var touch:Touch = event.getTouch(container);
			if (touch != null) {
				var phase:String = touch.phase;
				if (phase == TouchPhase.BEGAN) {
					// DOWN
					onTouchDown.dispatch(new Point(touch.globalX, touch.globalY));
				}
				else if (phase == TouchPhase.HOVER) {
					// HOVER MOVE
				}
				else if (phase == TouchPhase.ENDED) {
					// UP
				}
			}
			else {
				// OUT
			}
		}

	}

}