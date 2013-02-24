package engine.zones {
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author hlavko
	 */
	public class RectZone extends Zone {

		private var _rect:Rectangle;

		public function RectZone(rect:Rectangle) {
			super();
			_rect = rect;
		}

		public function get rect():Rectangle {
			return _rect;
		}

		public function set rect(value:Rectangle):void {
			_rect = value;
		}

	}

}