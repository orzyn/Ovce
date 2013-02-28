package engine.components {
	import flash.geom.Point;

	/**
	 * ...
	 * @author hlavko
	 */
	public class NavigationComponent extends BaseComponent {

		private var _phComp:PhysicsComponent;
		
		private var _distance:Number;
		private var _target:Point;
		private var _moving:Boolean;

		public function NavigationComponent() {
			super();
		}
		
		override public function start():void {
			_phComp = entity.getComponentByClass(PhysicsComponent);
		}

		override public function update():void {
			if (!_moving)
				return;

			var shiftX:int = _target.x - entity.x;
			var shiftY:int = _target.y - entity.y;
			
			_distance = Math.floor(Math.sqrt(Math.pow(shiftX, 2) + Math.pow(shiftY, 2)));

			if (_distance > 0) {
				if (_phComp.velocity <= _distance){
					var unitX:Number = (shiftX / _distance) * _phComp.velocity;
					var unitY:Number = (shiftY / _distance) * _phComp.velocity;

					entity.moveTo(entity.x + unitX, entity.y + unitY);
				}
				else {
					entity.moveTo(_target.x, _target.y);
				}
			} else
				_moving = false;
		}
		
		public function goTo(targetPoint:Point):void {
			_target = targetPoint;
			_moving = true;
		}

		public function get target():Point {
			return _target;
		}

		public function get distance():Number {
			if (_target == null)
				return 0;

			return _distance;
		}

		public function get moving():Boolean {
			return _moving;
		}

	}

}