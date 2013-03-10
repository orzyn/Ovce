package engine.components {
	import engine.zones.CircleZone;
	import engine.zones.Zone;
	import flash.geom.Point;

	/**
	 * ...
	 * @author hlavko
	 */
	public class ZoneComponent extends BaseComponent {

		private var _zone:CircleZone;

		public function ZoneComponent() {
			super();
		}

		public function get zone():CircleZone {
			return _zone;
		}

		public function set zone(value:CircleZone):void {
			_zone = value;
		}

	}

}