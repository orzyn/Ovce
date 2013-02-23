package game.behaviors {
	
	import engine.components.BehaviorComponent;
	import engine.components.InputComponent;
	import engine.components.RenderComponent;
	import engine.controllers.TouchController;
	import flash.geom.Point;
	import starling.display.MovieClip;
	import starling.events.Touch;

	/**
	 * ...
	 * @author hlavko
	 */
	public class CowBehavior extends BehaviorComponent {
		
		private var rComp:RenderComponent;
		private var controller:TouchController;
		
		private var clip:MovieClip;
		
		private var _velocity:Number = 1;
		private var _target:Point;

		public function CowBehavior() {
			super();
		}
		
		override public function start():void {
			rComp = entity.getComponentByClass(RenderComponent);
			clip = rComp.setActiveAnimation("cow_walk_down");
			clip.stop();
			clip.touchable = false;
			
			controller = entity.getComponentByClass(TouchController);
			controller.onTouchDown.add(onTouchDown);
		}
		
		override public function onTouchDown(target:Point):void {
			_target = target;
			
			var shiftX:int = rComp.x - _target.x;
			var shiftY:int = rComp.y - _target.y;
			
			if (Math.abs(shiftX) > Math.abs(shiftY)) {
				if (shiftX > 0) {
					clip = rComp.setActiveAnimation("cow_walk_left");
				}
				else {
					clip = rComp.setActiveAnimation("cow_walk_right");
				}
			}
			else {
				if (shiftY > 0) {
					clip = rComp.setActiveAnimation("cow_walk_up");
				}
				else {
					clip = rComp.setActiveAnimation("cow_walk_down");
				}
			}
			
			clip.touchable = false;
			clip.play();
		}
		
		override public function update():void {
			move();
		}
		
		private function move():void {
			if (_target == null)
				return;

			var shiftX:int = _target.x - rComp.x;
			var shiftY:int = _target.y - rComp.y;
			
			var distance:int = Math.floor(Math.sqrt(Math.pow(shiftX, 2) + Math.pow(shiftY, 2)));
			if (distance <= 0) {
				clip.stop();
				_target = null;
				return;
			}

			var unitX:Number = shiftX / distance;
			var unitY:Number = shiftY / distance;

			rComp.moveTo(rComp.x + unitX, rComp.y + unitY);
		}

	}

}