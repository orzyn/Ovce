package engine.core {
	
	import engine.components.BehaviorComponent;
	import engine.components.InputComponent;
	import engine.components.NavigationComponent;
	import engine.components.PhysicsComponent;
	import engine.components.RenderComponent;
	import engine.components.TriggerComponent;
	import engine.controllers.TouchController;
	import engine.physics.PhysicsFactory;
	import engine.zones.BoxZone;
	import engine.zones.CircleZone;
	import engine.zones.Zone;
	import flash.utils.getDefinitionByName;
	import game.behaviors.*;
	import nape.phys.Body;
	import nape.shape.Shape;

	/**
	 * ...
	 * @author hlavko
	 */
	public class Factory {

		static public function createEntity(xml:XML, layer:String):Entity {
			var entity:Entity = new Entity(String(xml.@id), layer);
			entity.moveTo(Number(xml.@x), Number(xml.@y));
			
			var comp:XML;
			for each(comp in xml.renderComponent) {
				entity.attachComponent(createRenderComponent(comp));
			}
			
			var name:String;
			for each(name in xml.behaviorComponent[0]) {
				entity.attachComponent(createBehaviorComponent(name));
			}
			
			for each(comp in xml.physicsComponent) {
				entity.attachComponent(createPhysicsComponent(comp));
			}
			
			for each(comp in xml.inputComponent[0]) {
				entity.attachComponent(createInputComponent(comp));
			}
			
			for each(comp in xml.triggerComponent) {
				entity.attachComponent(createTriggerComponent(comp));
			}
			
			for each(comp in xml.navigationComponent[0]) {
				entity.attachComponent(createNavigationComponent(comp));
			}
			
			return entity;
		}
		
		static private function createRenderComponent(xml:XML):RenderComponent {
			var comp:RenderComponent = new RenderComponent();
			
			var obj:XML;
			for each (obj in xml.image)
				comp.saveImage(obj, Boolean(int(obj.@active)));
			
			for each (obj in xml.clip)
				comp.saveClip(String(obj.@atlas), int(obj.@fps), String(obj), Boolean(int(obj.@active)));
			
			return comp;
		}
		
		static private function createBehaviorComponent(name:String):BehaviorComponent {
			return new (getDefinitionByName(name) as Class) as BehaviorComponent;
		}
		
		static private function createPhysicsComponent(xml:XML):PhysicsComponent {
			var body:Body = new Body(PhysicsFactory.createBodyType(xml.type))
			var comp:PhysicsComponent = new PhysicsComponent(body);
			
			var shape:Shape = PhysicsFactory.createShape(XML(xml.shape));
			comp.addShape(shape);
			
			comp.speed = Number(xml.speed);
			
			return comp;
		}
		static private function createInputComponent(type:String):InputComponent {
			if (type == "touch" || type == "mouse") {
				return new TouchController();
			}
			return null;
		}
		
		static private function createTriggerComponent(xml:XML):TriggerComponent {
			return null;
		}
		
		static private function createNavigationComponent(type:String):NavigationComponent {
			if (type == "direct"){
				return new NavigationComponent();
			}
			return null;
		}

	}

}
