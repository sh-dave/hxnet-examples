package;

import hxnet.interfaces.Connection;
import quads.Player;

class QuadsState {
	public var players = new Map<Connection, Player>();

	public function new() {
	}
}
