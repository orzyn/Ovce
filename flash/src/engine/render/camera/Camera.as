package engine.render.camera {

	/**
	 * ...
	 * @author hlavko
	 */
	public class Camera {
		
		private var _id:String;
		private var _x:int;
		private var _y:int;
		
		private var _invalidated:Boolean;

		public function Camera(id:String) {
			_id = id;
		}
		
		public function moveTo(x:int, y:int):void {
			if (_x != x || _y != y){				
				_x = x;
				_y = y;
				_invalidated = true;
			}
		}
		
		public function isInvalidated():Boolean {
			return _invalidated;
		}
		
		public function validate():void {
			_invalidated = true;
		}

	}

}