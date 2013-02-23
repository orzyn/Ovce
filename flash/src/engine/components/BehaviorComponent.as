package engine.components {
	import flash.geom.Point;
	import starling.events.Touch;

	/**
	 * ...
	 * @author hlavko
	 */
	public class BehaviorComponent extends BaseComponent {

		public function BehaviorComponent() {
			super();
		}
		
		public function onTouchDown(target:Point):void {
			// override me
		}

	}

}