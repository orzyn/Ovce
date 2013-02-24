package engine.core {

	import engine.components.BaseComponent;
	import engine.components.BehaviorComponent;
	import engine.components.InputComponent;
	import engine.components.RenderComponent;
	import engine.loaders.SceneLoader;
	import engine.render.Renderer;
	import engine.core.SignalBus;
	import org.osflash.signals.Signal;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * ...
	 * @author hlavko
	 */
	public class Engine {
		
		private var _renderer:Renderer;
		private var _bus:SignalBus;

		private var _entities:Vector.<Entity>;
		private var _behaviors:Vector.<BehaviorComponent>;
		private var _inputs:Vector.<InputComponent>;		
		
		private var _notLoadedComponents:Vector.<BaseComponent>;
		
		//////////////////////////////////////////////////
		// INITIALIZATION
		//////////////////////////////////////////////////

		public function Engine(canvas:Sprite) {
			init(canvas);
		}
		
		private function init(canvas:Sprite):void {
			_bus = new SignalBus();
			_bus.addSignal("onSceneStartup", Signal);
			
			_renderer = new Renderer(canvas);
		}
		
		//////////////////////////////////////////////////
		// SCENE LOADING
		//////////////////////////////////////////////////
		
		public function loadScene(sceneClass:Class):void {
			_notLoadedComponents = new Vector.<BaseComponent>();
			
			_entities = new Vector.<Entity>();
			_behaviors = new Vector.<BehaviorComponent>();
			_inputs = new Vector.<InputComponent>();
		
			SceneLoader.loadSceneXml(sceneClass);
			
			loadLayers();
			loadEntities();
		}
		
		private function loadLayers():void {
			_renderer.loadLayers(SceneLoader.loadLayerNames());
		}
		
		private function loadEntities():void {
			var entities:Vector.<Entity> = SceneLoader.loadEntities();
			var len:int = entities.length;
			
			for (var i:int = 0; i < len; i++) {
				addEntity(entities[i]);
			}
		}
		
		//////////////////////////////////////////////////
		// ENTITIES AND COMPONENTS MANAGEMENT
		//////////////////////////////////////////////////
		
		private function addEntity(entity:Entity):void {
			addRenderComponent(entity.getComponentByClass(RenderComponent), entity.layer);
			addBehaviorComponent(entity.getComponentByClass(BehaviorComponent));
			addInputComponent(entity.getComponentByClass(InputComponent));
		}
		
		private function addRenderComponent(component:RenderComponent, layer:String):void {
			if (component != null){
				_renderer.addComponentToLayer(component, layer);
				_notLoadedComponents.push(component);
			}
		}
		
		private function addBehaviorComponent(component:BehaviorComponent):void {
			if (component != null){
				_behaviors.push(component);
				_notLoadedComponents.push(component);
			}
		}
		
		private function addInputComponent(component:InputComponent):void {
			if (component != null) {
				_inputs.push(component);
				_notLoadedComponents.push(component);
			}
		}
		
		private function removeEntity(entity:Entity):void {
			// TODO
		}
		
		private function removeRenderComponent():void {
			// TODO
		}
		
		private function removeBehaviorComponent():void {
			// TODO
		}
		
		//////////////////////////////////////////////////
		// CORE EXECUTION
		//////////////////////////////////////////////////
		
		public function start():void {
			_bus.dispatchSignal("onSceneStartup");
			
			_renderer.canvas.addEventListener(Event.ENTER_FRAME, update);
		}

		private function update():void {
			loadComponents();
			// 0. update positions (physics / navigation)
			// 1. check collisions (physics / trigger)
			executeBehaviors(); // 2. exec behaviors (behavior)
			_renderer.render(); // 3. render view (render)
			// 4. play audio (audio)
		}
		
		private function loadComponents():void {
			var len:int = _notLoadedComponents.length;
			for (var i:int = 0; i < len; i++)
				if (!_notLoadedComponents[i].loaded)
					_notLoadedComponents[i].load(_bus, _renderer);
					
			_notLoadedComponents.splice(0, len);
		}
		
		private function executeBehaviors():void {
			var len:int = _behaviors.length;
			for (var i:int = 0; i < len; i++)
				_behaviors[i].update();
		}

	}

}