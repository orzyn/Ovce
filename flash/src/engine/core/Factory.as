package engine.core {
	
	import engine.components.BehaviorComponent;
	import engine.components.InputComponent;
	import engine.components.PhysicsComponent;
	import engine.components.RenderComponent;
	import engine.components.TriggerComponent;
	import engine.controllers.TouchController;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import game.behaviors.*;

	/**
	 * ...
	 * @author hlavko
	 */
	public class Factory {

		static public function createEntity(xml:XML, layer:String):Entity {
			var entity:Entity = new Entity(String(xml.@id), layer);
			
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
			
			return entity;
		}
		
		static private function createRenderComponent(xml:XML):RenderComponent {
			var comp:RenderComponent = new RenderComponent(int(xml.@x), int(xml.@y));
			
			var obj:XML;
			for each (obj in xml.sprite)
				comp.addSprite(obj, Boolean(int(obj.@active)));
			
			for each (obj in xml.anim)
				comp.addAnimation(String(obj.@atlas), int(obj.@fps), String(obj), Boolean(int(obj.@active)));
			
			return comp;
		}
		
		static private function createBehaviorComponent(name:String):BehaviorComponent {
			return new (getDefinitionByName(name) as Class) as BehaviorComponent;
		}
		
		static private function createPhysicsComponent(xml:XML):PhysicsComponent {
			return null;
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

	}

}
