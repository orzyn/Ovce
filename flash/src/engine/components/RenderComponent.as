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

		private var _x:Number;
		private var _y:Number;

		public function RenderComponent(x:int, y:int) {
			super();

			moveTo(x, y);

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

						moveTo(_x, _y);
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

						moveTo(_x, _y);
					}
					return MovieClip(_display);
				}
			}

			throw new ComponentError("Unable to set non-existing animation as active.");
		}

		public function moveTo(x:Number, y:Number):void {
			if (_display != null) {
				_display.x = x;
				_display.y = y;
			}

			_x = x;
			_y = y;
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

		public function get x():Number {
			return _x;
		}

		public function get y():Number {
			return _y;
		}

		public function getContainer():Sprite {
			return _container;
		}

	}

}