package engine.render.camera {
	import flash.geom.Point;

	/**
	 * ...
	 * @author hlavko
	 */
	public interface ICamera {
		function get x():int;
		function get y():int;
		function get anchorPoint():Point;
		function moveTo(x:int, y:int):void;
		function update():void;
		function validate():void;
		function isInvalidated():Boolean;
	}

}