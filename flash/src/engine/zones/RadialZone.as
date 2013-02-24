package engine.zones {

	/**
	 * ...
	 * @author hlavko
	 */
	public class RadialZone extends Zone {

		private var _radius:Number;

		public function RadialZone(radius:Number) {
			super();
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