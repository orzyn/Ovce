package game.behaviors {
	
	import engine.components.BehaviorComponent;
	import engine.components.InputComponent;
	import engine.components.NavigationComponent;
	import engine.components.PhysicsComponent;
	import engine.components.RenderComponent;
	import engine.controllers.TouchController;
	import engine.render.camera.LockCamera;
	import flash.geom.Point;
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.AABB;
	import starling.display.MovieClip;
	import starling.events.Touch;

	/**
	 * ...
	 * @author hlavko
	 */
	public class CowBehavior extends BehaviorComponent {
		
		private var navComp:NavigationComponent;
		private var phComp:PhysicsComponent;
		private var rComp:RenderComponent;
		private var controller:TouchController;
		
		private var clip:MovieClip;
		
		private var _velocity:Number = 1;
		private var _collisionListener:InteractionListener;
		private var _cowCollisionType:CbType = new CbType();
		
		
		public function CowBehavior() {
			super();
		}
		
		override public function start():void {
			navComp = entity.getComponentByClass(NavigationComponent);
			
			phComp = entity.getComponentByClass(PhysicsComponent);
			_collisionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, CbType.ANY_BODY, _cowCollisionType, onCollisionWithWorld);
			phComp.body.space.listeners.add(_collisionListener);
			phComp.body.cbTypes.add(_cowCollisionType);
			
			rComp = entity.getComponentByClass(RenderComponent);
			clip = rComp.setActiveClip("cow_walk_down");
			clip.stop();
			clip.touchable = false;
			
			bus.getSignal("onTriggerFinish").addOnce(finish);
			
			controller = entity.getComponentByClass(TouchController);
			controller.onTouchDown.add(onTouchDown);
			
			var cameraAnchor:Point = new Point(renderer.canvas.stage.stageWidth >> 1, renderer.canvas.stage.stageHeight >> 1);
			renderer.camera = new LockCamera(entity, "lockCamera", cameraAnchor);
		}
		
		override public function update():void {
			if (!navComp.moving) {
				clip.stop();
				return;
			}
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
			
			var aabb:AABB = phComp.body.shapes.at(0).bounds;
			aabb.width = clip.width;
			aabb.height = clip.height;
			
			clip.touchable = false;
			clip.play();
		}
		
		private function onCollisionWithWorld(collision:InteractionCallback):void {
			clip.stop();
		}
		
		private function finish():void {
			trace("finish")
		}

	}

}