package engine.core {
	
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;

	/**
	 * ...
	 * @author hlavko
	 */
	public class SignalBus {
		
		private var _signals:Dictionary;
		
		public function SignalBus() {
			_signals = new Dictionary();
		}
		
		public function addSignal(id:String, signalClass:Class):void {
			_signals[id] = new signalClass();
		}
		
		public function getSignal(id:String):Signal {
			return _signals[id];
		}
		
		public function dispatchSignal(id:String, ...params):void {
			if (params.length)
				Signal(getSignal(id)).dispatch(params);
			else
				Signal(getSignal(id)).dispatch();
		}

	}

}