package;

import haxe.io.Bytes;
import hxnet.base.Factory;
import hxnet.interfaces.Protocol;
import hxnet.protocols.WebSocket;
import hxnet.tcp.Server;

class ChatFactory implements hxnet.interfaces.Factory {
	public static var server : Server;

	public function new() {
	}

	public function buildProtocol() : Protocol {
		return new ChatService(server);
	}
}

class ChatService extends WebSocket {
	public var broadcaster : Server;

	public function new( server : Server ) {
		super();
		this.broadcaster = server;
	}

	override function recvText( text : String ) {
		trace('t>>> ${text}');
		broadcaster.broadcast(WebSocket.createFrame(Text(text)));
	}

	override function recvBinary( data : Bytes ) {
		trace('b>>> ${data.toString()}');
		broadcaster.broadcast(WebSocket.createFrame(Binary(data)));
	}
}

class Main {
	public static function main() {
		trace('websocket chat service');

		var server = new Server(new ChatFactory(), 54321, 'localhost');
		ChatFactory.server = server;
		server.start();
	}
}
