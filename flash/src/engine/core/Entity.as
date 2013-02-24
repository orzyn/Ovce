package engine.core {
	import engine.components.BaseComponent;
	import engine.errors.EntityError;

	/**
	 * ...
	 * @author hlavko
	 */
	public class Entity {

		private var _id:String;
		private var _layer:String;
		private var _x:Number;
		private var _y:Number;

		private var _components:Vector.<BaseComponent>;

		public function Entity(id:String, layer:String) {
			_id = id;
			_layer = layer;

			_components = new Vector.<BaseComponent>();
		}

		public function attachComponent(comp:BaseComponent):void {
			comp.entity = this;
			_components.push(comp);
		}

		public function removeComponentByClass(cl:Class):BaseComponent {
			var len:int = _components.length;

			for (var i:int = 0; i < len; i++)
				if (_components[i] is cl)
					return _components.splice(i, 1)[0];

			throw new EntityError("Component type '" + cl + "' is not attached to entity.");
		}

		public function getComponentByClass(cl:Class):* {
			var len:int = _components.length;

			for (var i:int = 0; i < len; i++)
				if (_components[i] is cl)
					return _components[i];

			return null;
		}

		public function get id():String {
			return _id;
		}
		
		public function get layer():String {
			return _layer;
		}

		public function get x():Number {
			return _x;
		}

		public function get y():Number {
			return _y;
		}
		
		public function moveTo(x:Number, y:Number):void {
			_x = x;
			_y = y;
		}

	}

}