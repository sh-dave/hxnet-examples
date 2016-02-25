package common;

import haxe.io.Bytes;
import hxnet.protocols.WebSocket;

class ClientProtocol extends WebSocket {
	var onText : String -> Void;
	var onBinary : Bytes -> Void;

	public function new( onText : String -> Void, onBinary : Bytes -> Void ) {
		super();
		this.onText = onText;
		this.onBinary = onBinary;
	}

	override function recvText( text : String ) {
		if (onText != null) {
			onText(text);
		}
	}

	override function recvBinary( data : Bytes ) {
		if (onBinary != null) {
			onBinary(data);
		}
	}
}
