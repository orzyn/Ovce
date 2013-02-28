package engine.render.camera {
	import engine.core.Entity;
	import flash.geom.Point;

	/**
	 * ...
	 * @author hlavko
	 */
	public class LockCamera implements ICamera {
		
		private var _x:int;
		private var _y:int;
		private var _id:Entity;
		private var _entity:Entity;
		private var _invalidated:Boolean;
		private var _anchorPoint:Point;

		public function LockCamera(entity:Entity, id:String, anchorPoint:Point) {
			_entity = entity;
			_anchorPoint = anchorPoint;
		}
		
		public function moveTo(x:int, y:int):void {
			if (_x != x || _y != y){
				_x = x;
				_y = y;
				_invalidated = true;
			}
		}
		
		public function update():void {
			moveTo(_entity.x, _entity.y);
		}
		
		public function validate():void {
			_invalidated = false;
		}
		
		public function isInvalidated():Boolean {
			return _invalidated;
		}
		
		public function get anchorPoint():Point {
			return _anchorPoint;
		}
		
		public function get x():int {
			return _x;
		}
		
		public function get y():int {
			return _y;
		}

	}

}