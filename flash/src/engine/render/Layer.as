package engine.render {

	import engine.components.RenderComponent;
	import engine.core.Entity;
	import starling.display.Sprite;

	/**
	 * ...
	 * @author hlavko
	 */
	public class Layer {

		private var _id:String;
		private var _container:Sprite;
		private var _components:Vector.<RenderComponent>;

		public function Layer(id:String) {
			_id = id;
			_container = new Sprite();
			_components = new Vector.<RenderComponent>();
		}

		public function addComponent(renderComponent:RenderComponent):void {
			_components.push(renderComponent);
			_container.addChild(renderComponent.getContainer());
		}

		public function getContainer():Sprite {
			return _container;
		}

		public function update():void {
			var len:int = _components.length;

			for (var i:int = 0; i < len; i++) {
				_components[i].update();
			}
		}

		public function get components():Vector.<RenderComponent> {
			return _components;
		}

		public function get id():String {
			return _id;
		}

	}

}