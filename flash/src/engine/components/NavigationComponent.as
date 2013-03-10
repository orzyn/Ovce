package engine.components {
	import flash.geom.Point;
	import nape.geom.Vec2;

	/**
	 * ...
	 * @author hlavko
	 */
	public class NavigationComponent extends BaseComponent {

		private var _phComp:PhysicsComponent;
		private var _renderComp:RenderComponent;
		private var _moving:Boolean;
		private var _target:Point;

		public function NavigationComponent() {
			super();
		}

		override public function start():void {
			_phComp = entity.getComponentByClass(PhysicsComponent);
			_renderComp = entity.getComponentByClass(RenderComponent);
		}

		override public function update():void {
			if (!_moving)
				
				return;
			if (distance > 2) {
				entity.moveTo(_phComp.body.position.x, _phComp.body.position.y);
			}
			else {
				_phComp.body.velocity = new Vec2(0, 0);
				_moving = false;
			}
		}

		public function goTo(targetPoint:Point):void {
			_target = targetPoint;

			_phComp.body.velocity = new Vec2(_target.x - entity.x, _target.y - entity.y).normalise().mul(_phComp.speed);

			_moving = true;
		}
		
		public function stop():void {
			_moving = false;
			
			_target.x = entity.x;
			_target.y = entity.y;
		}

		public function get distance():Number {
			if (_target == null)
				return 0;

			return _target.subtract(new Point(entity.x, entity.y)).length;
		}

		public function get moving():Boolean {
			return _moving;
		}

		public function get target():Point {
			return _target;
		}

	}

}