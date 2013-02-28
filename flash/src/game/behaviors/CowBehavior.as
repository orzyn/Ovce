package game.behaviors {
	
	import engine.components.BehaviorComponent;
	import engine.components.InputComponent;
	import engine.components.NavigationComponent;
	import engine.components.RenderComponent;
	import engine.controllers.TouchController;
	import engine.render.camera.LockCamera;
	import flash.geom.Point;
	import starling.display.MovieClip;
	import starling.events.Touch;

	/**
	 * ...
	 * @author hlavko
	 */
	public class CowBehavior extends BehaviorComponent {
		
		private var navComp:NavigationComponent;
		private var rComp:RenderComponent;
		private var controller:TouchController;
		
		private var clip:MovieClip;
		
		private var _velocity:Number = 1;
		
		public function CowBehavior() {
			super();
		}
		
		override public function start():void {
			navComp = entity.getComponentByClass(NavigationComponent);
			
			rComp = entity.getComponentByClass(RenderComponent);
			clip = rComp.setActiveClip("cow_walk_down");
			clip.stop();
			clip.touchable = false;
			
			controller = entity.getComponentByClass(TouchController);
			controller.onTouchDown.add(onTouchDown);
			
			var cameraAnchor:Point = new Point(renderer.canvas.stage.stageWidth >> 1, renderer.canvas.stage.stageHeight >> 1);
			renderer.camera = new LockCamera(entity, "lockCamera", cameraAnchor);
		}
		
		override public function onTouchDown(target:Point):void {
			var gotoPoint:Point = new Point(entity.x + target.x - (renderer.canvas.stage.stageWidth >> 1), entity.y + target.y - (renderer.canvas.stage.stageHeight >> 1));
			navComp.goTo(gotoPoint);
			
			var shiftX:int = entity.x - navComp.target.x;
			var shiftY:int = entity.y - navComp.target.y;
			
			if (Math.abs(shiftX) > Math.abs(shiftY)) {
				if (shiftX > 0) {
					clip = rComp.setActiveClip("cow_walk_left");
				}
				else {
					clip = rComp.setActiveClip("cow_walk_right");
				}
			}
			else {
				if (shiftY > 0) {
					clip = rComp.setActiveClip("cow_walk_up");
				}
				else {
					clip = rComp.setActiveClip("cow_walk_down");
				}
			}
			
			clip.touchable = false;
			clip.play();
		}
		
		override public function update():void {
			if (!navComp.moving) {
				clip.stop();
				return;
			}
		}

	}

}