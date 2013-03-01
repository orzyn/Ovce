package engine.zones {

	/**
	 * ...
	 * @author hlavko
	 */
	public class Zone {
		
		static public const CIRCLE:String = "circle";
		static public const BOX:String = "box";

		private var _type:String;

		public function Zone(type:String) {
			_type = type;
		}

		public function get type():String {
			return _type;
		}

	}

}