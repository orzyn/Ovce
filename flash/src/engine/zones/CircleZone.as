package engine.zones {

	/**
	 * ...
	 * @author hlavko
	 */
	public class CircleZone extends Zone {

		private var _radius:Number;

		public function CircleZone(radius:Number) {
			super(CIRCLE);
			_radius = radius;
		}

		public function get radius():Number {
			return _radius;
		}

		public function set radius(value:Number):void {
			_radius = value;
		}

	}

}