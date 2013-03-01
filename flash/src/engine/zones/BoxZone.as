package engine.zones {
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author hlavko
	 */
	public class BoxZone extends Zone {

		private var _width:Number
		private var _height:Number

		public function BoxZone(width:Number, height:Number) {
			super(BOX);
			_width = width;
			_height = height;
		}

		public function get width():Number {
			return _width;
		}

		public function set width(value:Number):void {
			_width = value;
		}

		public function get height():Number {
			return _height;
		}

		public function set height(value:Number):void {
			_height = value;
		}

	}

}