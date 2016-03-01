package;

import flash.display.Stage;
import flash.events.TimerEvent;
import flash.utils.Timer;
import hxnet.interfaces.Connection;
import mphxnet.hxnet.HxnetWebSocket.HxnetTextWSService;
import quads.QuadsProtocol;

class QuadsClientService extends HxnetTextWSService {
	var entered(default, default) : String -> Void;
	var library : Library;

	public function new( library : Library, entered : String -> Void ) {
		super();

		this.library = library;
		//this.stage = stage;
		this.entered = entered;
		onConnected = this_connectedHandler;
		onReceived = this_receivedHandler;
	}

	function this_connectedHandler( connection : Connection ) {
		//trace('QuadsService.this_connectedHandler');

// TODO (DK) not sure yet why a delay is neccessary
		var t = new Timer(2500, 1);
		t.addEventListener(TimerEvent.TIMER, function( _ ) {
			sendCommand(Enter);
		});
		t.start();

		//trace('/QuadsService.this_connectedHandler');
	}

	function this_receivedHandler( data : String ) {
		//trace('QuadsService.this_receivedHandler [${data}]');
		var command = QuadsProtocol.decode(data);

		switch (command) {
			case ServerInterface.Entered(id, players): {
				entered(id);

				for (player in players) {
					library.createPlayer(player.id, player.x, player.y, player.color);
				}
			}
			case ServerInterface.Joined(id, x, y, color): {
				library.createPlayer(id, x, y, color);
			}
			case ServerInterface.Moved(id, x, y): {
				library.updatePlayerPosition(id, x, y);
			}
		}
		//trace('/QuadsService.this_receivedHandler');
	}

	public function sendCommand( command : ClientInterface ) {
		send(QuadsProtocol.encode(command));
	}
}
