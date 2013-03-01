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

			for (var i:int = 0; i < len; i++)
				_components[i].update();
				
			_components.sort(sortFunction);
			
			for (i = len - 1; i >= 0; i--)
				_container.setChildIndex(_components[i].getContainer(), i);
		}
		
		private function sortFunction(first:RenderComponent, second:RenderComponent):Number {
			if (first.entity.y > second.entity.y)
				return 1;
			else 
				return -1;
		}

		public function get components():Vector.<RenderComponent> {
			return _components;
		}

		public function get id():String {
			return _id;
		}

	}

}