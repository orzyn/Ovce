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
		
		private var _images:Vector.<Image>;
		private var _clips:Vector.<MovieClip>;

		private var _display:DisplayObject;

		public function RenderComponent() {
			super();

			_container = new Sprite();
			_images = new Vector.<Image>();
			_clips = new Vector.<MovieClip>();
		}

		public function saveImage(template:String, active:Boolean):void {
			var image:Image = new Image(TexturesLoader.getTexture(template));
			image.pivotX = image.width >> 1;
			image.pivotY = image.height >> 1;
			image.name = template;
			_images.push(image);

			if (active)
				setActiveImage(template);
		}
		
		public function addSprite(sprite:Sprite):void {
			_container.addChild(sprite);
		}

		public function saveClip(atlas:String, fps:uint, template:String, active:Boolean):void {
			var clip:MovieClip = new MovieClip(TexturesLoader.getTextureAtlas(atlas).getTextures(template), fps);
			clip.pivotX = clip.width >> 1;
			clip.pivotY = clip.height >> 1;
			clip.name = template;
			_clips.push(clip);

			if (active)
				setActiveClip(template);
		}

		public function disposeImage(template:String):void {
			var len:int = _images.length;

			for (var i:int = 0; i < len; i++) {
				if (_images[i].name == template) {
					_images.splice(i, 1);
					return;
				}
			}

			throw new ComponentError("Unable to dispose image.");
		}

		public function disposeClip(template:String):void {
			var len:int = _clips.length;

			for (var i:int = 0; i < len; i++) {
				if (_clips[i].name == template) {
					_clips.splice(i, 1);
					return;
				}
			}

			throw new ComponentError("Unable to dispose clip.");
		}

		public function setActiveImage(template:String):void {
			var len:int = _images.length;

			for (var i:int = 0; i < len; i++) {
				if (_images[i].name == template) {
					if (_display != _images[i]) {
						if (_display != null) {
							if (_display is IAnimatable)
								Starling.juggler.remove(IAnimatable(_display));
							_container.removeChild(_display);
						}

						_display = _images[i];
						_container.addChild(_display);
					}
					return;
				}
			}

			throw new ComponentError("Unable to set non-existing sprite as active.");
		}

		public function setActiveClip(template:String):MovieClip {
			var len:int = _clips.length;

			for (var i:int = 0; i < len; i++) {
				if (_clips[i].name == template) {
					if (_display != _clips[i]) {
						if (_display != null) {
							if (_display is IAnimatable)
								Starling.juggler.remove(IAnimatable(_display));
							_container.removeChild(_display);
						}

						_display = _clips[i];						
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

		public function get images():Vector.<Image> {
			return _images;
		}

		public function get clips():Vector.<MovieClip> {
			return _clips;
		}

		public function get display():DisplayObject {
			return _display;
		}

		public function getContainer():Sprite {
			return _container;
		}

	}

}