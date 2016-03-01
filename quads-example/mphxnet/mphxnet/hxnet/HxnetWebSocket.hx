package mphxnet.hxnet;

import haxe.io.Bytes;
import hxnet.interfaces.Connection;
import hxnet.interfaces.Server;
import hxnet.protocols.WebSocket;

class HxnetBinaryWSService extends WebSocket implements mphxnet.BinaryService {
	public var onReceived(default, default) : Bytes -> Void;
	public var onConnected(default, default) : Connection -> Void;

	public function new() {
		super();
	}

	override public function onConnect( connection : Connection ) {
		super.onConnect(connection);

		if (onConnected != null) {
			onConnected(connection);
		}
	}

	override public function onAccept( connection : Connection, server : Server ) {
		super.onAccept(connection, server);

		if (onConnected != null) {
			onConnected(connection);
		}
	}

	public function send( data : Bytes ) {
		sendBinary(data);
	}

	override function recvBinary( data : Bytes ) {
		if (onReceived != null) {
			onReceived(data);
		}
	}

	public function broadcast( data : Bytes ) {
		if (server != null) {
			server.broadcast(WebSocket.createFrame(Binary(data)));
		} else {
			trace('server is null');
		}
	}
}

class HxnetTextWSService extends WebSocket implements mphxnet.TextService {
	public var onReceived(default, default) : String -> Void;
	public var onConnected(default, default) : Connection -> Void;

	override public function onConnect( connection : Connection ) {
		//trace('HxnetTextWebsocketAdapter.onConnect');

		super.onConnect(connection);

		if (onConnected != null) {
			//trace('HxnetTextWebsocketAdapter.onConnected callback');
			onConnected(connection);
		}

		//trace('/HxnetTextWebsocketAdapter.onConnect');
	}

	override public function onAccept( connection : Connection, server : Server ) {
		//trace('HxnetTextWebsocketAdapter.onAccept');

		super.onAccept(connection, server);

		if (onConnected != null) {
			//trace('HxnetTextWebsocketAdapter.onConnected callback');
			onConnected(connection);
		}

		//trace('/HxnetTextWebsocketAdapter.onAccept');
	}

	public function send( data : String ) {
		//trace('HxnetTextWebsocketAdapter.send ${data}');
		trace('> ${data}');
		sendText(data);
		//trace('/HxnetTextWebsocketAdapter.send ${data}');
	}

	public function broadcast( data : String ) {
		if (server != null) {
			trace('>>> ${data}');
			server.broadcast(WebSocket.createFrame(Text(data)));
		} else {
			trace('server is null');
		}
	}

	override function recvText( data : String ) {
		if (onReceived != null) {
			onReceived(data);
		}
	}
}
