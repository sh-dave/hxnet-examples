package quads;

import hxnet.interfaces.Connection;
import hxnet.protocols.WebSocket;

// client to server messaging
enum ClientInterface {
	Enter;
	Move(id : String, x : Int, y : Int);
}

// server to client messaging
enum ServerInterface {
	Entered(id : String, players : Array<Player>);
	Joined(id : String, x : Int, y : Int, color : Int);
	Moved(id : String, x : Int, y : Int);
}

class QuadsProtocol {
	public static function encode<T>( command : T ) : String {
		return haxe.Serializer.run(command);
	}

	public static function decode<T>( data : String ) : T {
		return cast haxe.Unserializer.run(data);
	}
}
