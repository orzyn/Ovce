package game {
	
	import engine.core.Entity;
	import engine.core.Engine;
	import engine.loaders.SceneLoader;
	import engine.loaders.TexturesLoader;
	import game.assets.Cow;
	import game.assets.Terrain;
	import game.behaviors.CowBehavior;
	import game.levels.Level;
	import starling.display.Sprite;

	/**
	 * ...
	 * @author hlavko
	 */
	public class Game extends Sprite {
		
		private var _engine:Engine;
		
		public function Game() {
			super();
			init();
		}
		
		private function init():void {
			new CowBehavior;
			
			TexturesLoader.loadTexture("meadow-green", Terrain.MeadowImage);
			TexturesLoader.loadTextureAtlas("cow-walk", Cow.AnimTexture, Cow.AnimData);
			
			_engine = new Engine(this);
			_engine.loadScene(Level.Level001);
			_engine.start();
		}

	}

}