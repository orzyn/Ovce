package engine.render {

	import engine.components.RenderComponent;
	import engine.core.Entity;
	import engine.loaders.SceneLoader;
	import engine.render.camera.Camera;
	import flash.utils.Dictionary;
	import starling.display.Sprite;

	/**
	 * ...
	 * @author hlavko
	 */
	public class Renderer {

		private var _canvas:Sprite;
		private var _layers:Dictionary;
		private var _camera:Camera;

		public function Renderer(canvas:Sprite) {
			_canvas = canvas;
			_layers = new Dictionary();
			_camera = new Camera("staticCamera");
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
			updateCamera();
		}
		
		private function updateCamera():void {
			// TODO - validate position in depth
			// TODO - camera update
		}

		public function set camera(value:Camera):void {
			_camera = value;
			// TODO
		}

		public function get canvas():Sprite {
			return _canvas;
		}

	}

}