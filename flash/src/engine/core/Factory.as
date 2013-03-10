package engine.core {
	
	import engine.components.BehaviorComponent;
	import engine.components.InputComponent;
	import engine.components.NavigationComponent;
	import engine.components.PhysicsComponent;
	import engine.components.RenderComponent;
	import engine.components.ZoneComponent;
	import engine.controllers.TouchController;
	import engine.physics.PhysicsFactory;
	import engine.trigger.Trigger;
	import engine.zones.CircleZone;
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
			
			for each(comp in xml.zoneComponent) {
				entity.attachComponent(createZoneComponent(comp));
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
		
		static private function createZoneComponent(xml:XML):ZoneComponent {
			var comp:ZoneComponent = new ZoneComponent();
			
			var zoneType:String = xml.zone.@type;
			
			switch (zoneType) {
				case "circle":
					comp.zone = new CircleZone(xml.zone.@radius);
					break;
					
				case "rect":
					// TODO - rectangle zone loading
					break;
			}
			
			return comp;
		}
		
		static private function createNavigationComponent(type:String):NavigationComponent {
			if (type == "direct"){
				return new NavigationComponent();
			}
			return null;
		}

		static public function createTrigger(entities:Vector.<Entity>, xml:XML):Trigger {
			var trigger:Trigger = new Trigger();
			
			var data:String;
			var entitiesNum:int = entities.length;
			var i:int;
			
			for each (data in xml.zone) {
				for (i = 0; i < entitiesNum; i++) {
					if (entities[i].id == data)
						trigger.addZone(entities[i].getComponentByClass(ZoneComponent));
				}
			}
			
			for each (data in xml.signal)
				trigger.signal = data;
				
			return trigger;
		}
	}

}
