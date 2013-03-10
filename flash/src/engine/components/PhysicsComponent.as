package engine.components {

	import engine.physics.PhysicsFactory;
	import engine.zones.Zone;
	import nape.callbacks.CbEvent;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.phys.Body;
	import nape.shape.Shape;

	/**
	 * ...
	 * @author hlavko
	 */
	public class PhysicsComponent extends BaseComponent {

		private var _body:Body;
		private var _speed:Number = 0;

		public function PhysicsComponent(body:Body) {
			super();
			_body = body;
			_body.allowRotation = false;
		}

		override public function start():void {
			_body.position.setxy(entity.x, entity.y);
		}

		private function onCollisionHandler(interactionCallback:InteractionCallback):void {
			//interactionCallback.
		}

		public function addShape(shape:Shape):void {
			_body.shapes.add(shape);
		}

		public function moveTo(x:Number, y:Number):void {
			_body.position.x = x;
			_body.position.y = y;
		}

		public function get body():Body {
			return _body;
		}

		public function get speed():Number {
			return _speed;
		}

		public function set speed(value:Number):void {
			_speed = value;
		}

	}

}