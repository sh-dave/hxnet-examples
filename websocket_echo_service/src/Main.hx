package;

import haxe.io.Bytes;
import hxnet.base.Factory;
import hxnet.protocols.WebSocket;
import hxnet.tcp.Server;

class EchoService extends WebSocket {
	override function recvText( text : String ) {
		trace('t> ${text}');
		sendText(text);
	}

	override function recvBinary( data : Bytes ) {
		trace('b> ${data.toString()}');
		sendBinary(data);
	}
}

class Main {
	public static function main() {
		trace('websocket echo service');
		var server = new Server(new Factory(EchoService), 54321, 'localhost');
		server.start();
	}
}
