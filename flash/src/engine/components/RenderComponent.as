package engine.components {

	import engine.errors.ComponentError;
	import engine.loaders.TexturesLoader;
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;

	/**
	 * ...
	 * @author hlavko
	 */
	public class RenderComponent extends BaseComponent {

		private var _container:Sprite;
		private var _sprites:Vector.<Image>;
		private var _animations:Vector.<MovieClip>;

		private var _display:DisplayObject;

		public function RenderComponent() {
			super();

			_container = new Sprite();
			_sprites = new Vector.<Image>();
			_animations = new Vector.<MovieClip>();
		}

		public function addSprite(template:String, active:Boolean):void {
			var sprite:Image = new Image(TexturesLoader.getTexture(template));
			sprite.pivotX = sprite.width >> 1;
			sprite.pivotY = sprite.height >> 1;
			sprite.name = template;
			_sprites.push(sprite);

			if (active)
				setActiveSprite(template);
		}

		public function addAnimation(atlas:String, fps:uint, template:String, active:Boolean):void {
			var clip:MovieClip = new MovieClip(TexturesLoader.getTextureAtlas(atlas).getTextures(template), fps);
			clip.pivotX = clip.width >> 1;
			clip.pivotY = clip.height >> 1;
			clip.name = template;
			_animations.push(clip);

			if (active)
				setActiveAnimation(template);
		}

		public function disposeSprite(template:String):void {
			var len:int = _sprites.length;

			for (var i:int = 0; i < len; i++) {
				if (_sprites[i].name == template) {
					_sprites.splice(i, 1);
					return;
				}
			}

			throw new ComponentError("Unable to dispose sprite.");
		}

		public function disposeAnimation(template:String):void {
			var len:int = _animations.length;

			for (var i:int = 0; i < len; i++) {
				if (_animations[i].name == template) {
					_animations.splice(i, 1);
					return;
				}
			}

			throw new ComponentError("Unable to dispose animation.");
		}

		public function setActiveSprite(template:String):void {
			var len:int = _sprites.length;

			for (var i:int = 0; i < len; i++) {
				if (_sprites[i].name == template) {
					if (_display != _sprites[i]) {
						if (_display != null) {
							if (_display is IAnimatable)
								Starling.juggler.remove(IAnimatable(_display));
							_container.removeChild(_display);
						}

						_display = _sprites[i];
						_container.addChild(_display);
					}
					return;
				}
			}

			throw new ComponentError("Unable to set non-existing sprite as active.");
		}

		public function setActiveAnimation(template:String):MovieClip {
			var len:int = _animations.length;

			for (var i:int = 0; i < len; i++) {
				if (_animations[i].name == template) {
					if (_display != _animations[i]) {
						if (_display != null) {
							if (_display is IAnimatable)
								Starling.juggler.remove(IAnimatable(_display));
							_container.removeChild(_display);
						}

						_display = _animations[i];						
						_container.addChild(_display);

						Starling.juggler.add(IAnimatable(_display));
					}
					return MovieClip(_display);
				}
			}

			throw new ComponentError("Unable to set non-existing animation as active.");
		}
		
		override public function update():void {
			if (_display != null) {
				_display.x = entity.x;
				_display.y = entity.y;
			}
		}

		public function get sprites():Vector.<Image> {
			return _sprites;
		}

		public function get animations():Vector.<MovieClip> {
			return _animations;
		}

		public function get display():DisplayObject {
			return _display;
		}

		public function getContainer():Sprite {
			return _container;
		}

	}

}