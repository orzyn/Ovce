package engine.render {

	import engine.components.RenderComponent;
	import engine.core.Entity;
	import engine.loaders.SceneLoader;
	import engine.render.camera.ICamera;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import starling.display.Sprite;

	/**
	 * ...
	 * @author hlavko
	 */
	public class Renderer {

		private var _canvas:Sprite;
		private var _layers:Dictionary;
		private var _camera:ICamera;

		public function Renderer(canvas:Sprite) {
			_canvas = canvas;
			_layers = new Dictionary();
		}

		public function loadLayers(layerNames:Vector.<String>):void {
			var num:int = layerNames.length;
			var layer:Layer;

			for (var i:int = 0; i < num; i++) {
				layer = new Layer(layerNames[i]);
				_layers[layer.id] = layer;
				_canvas.addChild(layer.getContainer());
			}
		}

		public function addComponentToLayer(component:RenderComponent, layer:String):void {
			Layer(_layers[layer]).addComponent(component);
		}

		public function getLayer(layerName:String):Layer {
			return _layers[layerName];
		}

		public function render():void {
			validatePositions();
			updateCamera();
		}

		private function validatePositions():void {
			var layer:Layer;

			for each (layer in _layers) {
				layer.update();
			}
		}

		private function updateCamera():void {
			if (_camera != null){
				camera.update();
				
				if (camera.isInvalidated()) {
					var layer:Layer;
					var container:Sprite;
					var anchor:Point;
					
					for each (layer in _layers) {
						container = layer.getContainer();
						anchor = camera.anchorPoint;
						container.x = anchor.x - camera.x;
						container.y = anchor.y - camera.y;
					}
				}
			}
		}

		public function get camera():ICamera {
			return _camera;
		}

		public function set camera(value:ICamera):void {
			_camera = value;
		}

		public function get canvas():Sprite {
			return _canvas;
		}

	}

}