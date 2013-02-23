package engine.loaders {
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * ...
	 * @author hlavko
	 */
	public class TexturesLoader {
		
		static private var _textures:Dictionary = new Dictionary();
		static private var _atlases:Dictionary = new Dictionary();

		static public function loadTexture(name:String, textureClass:Class):void {
			var tex:Texture = Texture.fromBitmap(new textureClass());
			_textures[name] = tex;
		}
		
		static public function getTexture(name:String):Texture {
			return _textures[name];
		}
		
		static public function loadTextureAtlas(name:String, textureClass:Class, dataClass:Class):void {
			var tex:Texture = Texture.fromBitmap(new textureClass());
			var data:XML = XML(new dataClass());
			var atlas:TextureAtlas = new TextureAtlas(tex, data);
			_atlases[name] = atlas;
		}
		
		static public function getTextureAtlas(name:String):TextureAtlas {
			return _atlases[name];
		}

	}

}