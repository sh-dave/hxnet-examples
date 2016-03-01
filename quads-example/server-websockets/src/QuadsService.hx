package;

import hxnet.interfaces.Connection;
import mphxnet.hxnet.HxnetWebSocket.HxnetTextWSService;
import quads.Player;
import quads.QuadsProtocol;

class QuadsService extends HxnetTextWSService {
	var state : QuadsState;
	var movementSpeed = 10;

	public function new( state : QuadsState ) {
		super();

		this.state = state;

		onConnected = this_onConnectedHandler;
		onReceived = this_onReceivedHandler;
	}

	function this_onConnectedHandler( connection : Connection ) {
		//trace('QuadsService.connected');
		var player = new Player(0, 0, Std.int(0xffffff * Math.random()));
		state.players.set(connection, player);
		//trace('/QuadsService.connected');
	}

	function this_onReceivedHandler( data : String ) {
		//trace('QuadsService.received');
		var command : ClientInterface = QuadsProtocol.decode(data);

		switch (command) {
			case ClientInterface.Enter: {
				var player = state.players.get(cnx);

				if (player == null) {
					trace('invalid player id');
					return;
				}

				// (DK) tell the client his id
				send(QuadsProtocol.encode(ServerInterface.Entered(player.id, [for (player in state.players) player])));

// TODO (DK) this didn't work out, so pass all current players in Command.Entered for now
				// (DK) tell client about old clients
				//for (player in state.players) {
					//send(QuadsProtocol.encode(Command.Joined(player.id, player.x, player.y, player.color)));
				//}

				// (DK) tell old clients about new client
				broadcast(QuadsProtocol.encode(ServerInterface.Joined(player.id, player.x, player.y, player.color)));
			}
			case ClientInterface.Move(id, x, y): {
				var player = state.players.get(cnx);

				if (player != null) {
					player.x += x * movementSpeed;
					player.y += y * movementSpeed;

					broadcast(QuadsProtocol.encode(ServerInterface.Moved(player.id, player.x, player.y)));
				} else {
					trace('invalid player id');
				}
			}
		}
		//trace('/QuadsService.received');
	}
}
