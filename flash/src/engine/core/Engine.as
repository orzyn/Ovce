package engine.core {

	import engine.components.BaseComponent;
	import engine.components.BehaviorComponent;
	import engine.components.InputComponent;
	import engine.components.NavigationComponent;
	import engine.components.PhysicsComponent;
	import engine.components.RenderComponent;
	import engine.components.ZoneComponent;
	import engine.loaders.SceneLoader;
	import engine.render.Renderer;
	import engine.core.SignalBus;
	import engine.signals.TriggerSignal;
	import engine.trigger.Trigger;
	import flash.display.MovieClip;
	import nape.geom.Vec2;
	import nape.space.Space;
	import nape.util.Debug;
	import nape.util.ShapeDebug;
	import org.osflash.signals.Signal;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * ...
	 * @author hlavko
	 */
	public class Engine {

		private var _renderer:Renderer;
		private var _bus:SignalBus;
		private var _space:Space;
		private var _triggers:Vector.<Trigger>;
		
		private var _debug:Debug;

		private var _entities:Vector.<Entity>;
		private var _behaviors:Vector.<BehaviorComponent>;
		private var _inputs:Vector.<InputComponent>;
		private var _physics:Vector.<PhysicsComponent>;
		private var _navigations:Vector.<NavigationComponent>;
		private var _zones:Vector.<ZoneComponent>;

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
			_space = new Space();
			
			initPhysicsDebug();
		}
		
		private function initPhysicsDebug():void {
			_debug = new ShapeDebug(800, 480, 0x33333333);
			var mcDebug:MovieClip = new MovieClip();
			mcDebug.addChild(_debug.display);
			Starling.current.nativeOverlay.addChild(mcDebug);
			_renderer.mcPhysicsDebug = mcDebug;
		}

		//////////////////////////////////////////////////
		// SCENE LOADING
		//////////////////////////////////////////////////

		public function loadScene(sceneClass:Class):void {
			_notLoadedComponents = new Vector.<BaseComponent>();

			_entities = new Vector.<Entity>();
			_behaviors = new Vector.<BehaviorComponent>();
			_inputs = new Vector.<InputComponent>();
			_physics = new Vector.<PhysicsComponent>();
			_navigations = new Vector.<NavigationComponent>();
			_zones = new Vector.<ZoneComponent>();

			SceneLoader.loadSceneXml(sceneClass);

			loadPhysics();
			loadLayers();
			loadEntities();
			loadTriggers();
		}
		
		private function loadPhysics():void {
			_space.gravity = Vec2.fromPoint(SceneLoader.loadGravity());
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
		
		private function loadTriggers():void {
			_triggers = SceneLoader.loadTriggers(_entities);
			
			var len:int = _triggers.length;
			
			for (var i:int = 0; i < len; i++) {
				_bus.addSignal(_triggers[i].signal, TriggerSignal);
			}
		}

		//////////////////////////////////////////////////
		// ENTITIES AND COMPONENTS MANAGEMENT
		//////////////////////////////////////////////////

		private function addEntity(entity:Entity):void {
			_entities.push(entity);
			
			addRenderComponent(entity.getComponentByClass(RenderComponent), entity.layer);
			addNavigationComponent(entity.getComponentByClass(NavigationComponent));
			addBehaviorComponent(entity.getComponentByClass(BehaviorComponent));
			addInputComponent(entity.getComponentByClass(InputComponent));
			addPhysicsComponent(entity.getComponentByClass(PhysicsComponent));
		}

		private function addRenderComponent(component:RenderComponent, layer:String):void {
			if (component != null) {
				_renderer.addComponentToLayer(component, layer);
				_notLoadedComponents.push(component);
			}
		}

		private function addBehaviorComponent(component:BehaviorComponent):void {
			if (component != null) {
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

		private function addPhysicsComponent(component:PhysicsComponent):void {
			if (component != null) {
				_physics.push(component);
				_notLoadedComponents.push(component);
				component.body.space = _space;
			}
		}

		private function addNavigationComponent(component:NavigationComponent):void {
			if (component != null) {
				_navigations.push(component);
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

		private function removePhysicsComponent():void {
			// TODO
		}

		private function removeNavigationComponent():void {
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
			loadComponents(); // 0. initialize components which are not loaded yet
			updatePhysics(); // 1. check collisions (physics)
			checkTriggers(); // 2. trigger collisions
			validatePositions(); // 3. apply physics coords to rendering
			executeBehaviors(); // 4. exec behaviors (behavior)
			render(); // 5. render view (render)
			// 6. play audio (audio)
		}

		private function loadComponents():void {
			var len:int = _notLoadedComponents.length;

			for (var i:int = 0; i < len; i++)
				if (!_notLoadedComponents[i].loaded)
					_notLoadedComponents[i].load(_bus, _renderer);

			_notLoadedComponents.splice(0, len);
		}
		
		private function updatePhysics():void {
			_space.step(0.017);

			_debug.clear();
			_debug.draw(_space);
			_debug.flush();
		}
		
		private function checkTriggers():void {
			var len:int = _triggers.length;
			
			for (var i:int = 0; i < len; i++){
				if (!_triggers[i].triggered && _triggers[i].test()) {
					_bus.dispatchSignal(_triggers[i].signal);
				}
			}
		}
		
		private function validatePositions():void {
			var len:int = _navigations.length;

			for (var i:int = 0; i < len; i++)
				_navigations[i].update();
		}

		private function executeBehaviors():void {
			var len:int = _behaviors.length;

			for (var i:int = 0; i < len; i++)
				_behaviors[i].update();
		}
		
		private function render():void {
			_renderer.render(); 
		}

		//////////////////////////////////////////////////
		// GETTERS
		//////////////////////////////////////////////////

		public function get renderer():Renderer {
			return _renderer;
		}

		public function get bus():SignalBus {
			return _bus;
		}

	}

}