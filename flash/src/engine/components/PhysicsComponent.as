package engine.components {
	import engine.zones.Zone;

	/**
	 * ...
	 * @author hlavko
	 */
	public class PhysicsComponent extends BaseComponent {

		private var _velocity:Number;
		private var _collider:Zone;

		public function PhysicsComponent() {
			super();
		}

		public function get velocity():Number {
			return _velocity;
		}

		public function set velocity(value:Number):void {
			_velocity = value;
		}

		public function get collider():Zone {
			return _collider;
		}

		public function set collider(value:Zone):void {
			_collider = value;
		}

	}

}