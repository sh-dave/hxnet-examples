package;

import hxnet.interfaces.Factory;
import hxnet.interfaces.Protocol;

class QuadsServiceFactory implements Factory {
	var state : QuadsState;

	public function new( state : QuadsState ) {
		this.state = state;
	}

	public function buildProtocol() : Protocol {
		return new QuadsService(state);
	}
}
