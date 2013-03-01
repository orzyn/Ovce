package engine.physics {
	import engine.errors.PhysicsError;
	import engine.zones.BoxZone;
	import engine.zones.CircleZone;
	import engine.zones.Zone;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.shape.Shape;

	/**
	 * ...
	 * @author hlavko
	 */
	public class PhysicsFactory {

		static public function createBodyType(type:String):BodyType {
			var bodyType:BodyType;
			
			switch(type) {
				case "static":
					return BodyType.STATIC;
					
				case "dynamic":
					return BodyType.DYNAMIC;
					
				case "kinematic":
					return BodyType.KINEMATIC;
			}
			
			throw new PhysicsError("unable to create body type '" + type + "'");
		}
		
		static public function createShape(xml:XML):Shape {
			var type:String = xml.@type;
			if (type == "box") {
				return new Polygon(Polygon.box(Number(xml.@width), Number(xml.@height)));
			}
			else if (type == "circle") {
				return new Circle(Number(xml.@radius));
			}
			
			throw new PhysicsError("unable to create shape from zone type '" + type + "'");
		}

	}

}