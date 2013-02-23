package engine.loaders {
	import engine.core.Entity;
	import engine.core.Factory;
	import engine.render.Layer;
	import flash.utils.ByteArray;

	/**
	 * ...
	 * @author hlavko
	 */
	public class SceneLoader {
		
		static private var _xml:XML;
		
		static public function loadSceneXml(sceneClass:Class):void {
			_xml = XML(new sceneClass());
		}
		
		static public function loadLayerNames():Vector.<String> {
			var layerNames:Vector.<String> = new Vector.<String>();
			
			var layerData:XML;
			for each(layerData in _xml.layer)
				layerNames.push(layerData.@id);
			
			return layerNames;
		}

		static public function loadEntities():Vector.<Entity> {
			var entities:Vector.<Entity> = new Vector.<Entity>();
			
			var entityData:XML;
			for each(entityData in _xml.layer.entity)
				entities.push(Factory.createEntity(entityData, entityData.parent().@id));
			
			return entities;
		}

	}

}