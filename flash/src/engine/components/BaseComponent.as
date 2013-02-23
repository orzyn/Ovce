package engine.components {
	import engine.core.Entity;
	import engine.core.SignalBus;
	import engine.render.Renderer;

	/**
	 * ...
	 * @author hlavko
	 */
	public class BaseComponent {
		
		private var _loaded:Boolean;
		
		protected var bus:SignalBus;
		protected var renderer:Renderer;
		
		private var _entity:Entity;

		public function BaseComponent() {
		}

		final public function load(bus:SignalBus, renderer:Renderer):void {
			this.bus = bus;
			this.renderer = renderer;
			
			_loaded = true;
			
			start();
		}

		public function start():void {
			// override me
		}

		public function update():void {
			// override me
		}
		
		public function dispose():void {
			bus = null;
			renderer = null;
		}

		public function get loaded():Boolean {
			return _loaded;
		}
		
		public function get entity():Entity {
			return _entity;
		}

		public function set entity(value:Entity):void {
			_entity = value;
		}

	}

}