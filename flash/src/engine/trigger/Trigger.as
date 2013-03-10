package engine.trigger {

	import engine.components.ZoneComponent;
	import flash.geom.Point;

	/**
	 * ...
	 * @author hlavko
	 */
	public class Trigger {

		private var _zones:Vector.<ZoneComponent>;
		private var _signal:String;
		private var _triggered:Boolean = false;

		public function Trigger() {
			init();
		}
		
		private function init():void {
			_zones = new Vector.<ZoneComponent>();
		}

		public function addZone(zone:ZoneComponent):void {
			_zones.push(zone);
		}

		public function get triggered():Boolean {
			return _triggered;
		}

		public function get signal():String {
			return _signal;
		}

		public function set signal(value:String):void {
			_signal = value;
		}

		public function test():Boolean {
			var i:int, j:int, iNum:int, jNum:int;
			var iPos:Point, jPos:Point, distance:Number;

			for (i = 0; i < _zones.length; i++) {
				for (j = i + 1; j < _zones.length; j++) {
					iPos = _zones[i].entity.position;
					jPos = _zones[j].entity.position;
					distance = iPos.subtract(jPos).length;

					if (distance < _zones[i].zone.radius + _zones[j].zone.radius) {
						return _triggered = true;
					}
				}
			}

			return _triggered;
		}

	}

}