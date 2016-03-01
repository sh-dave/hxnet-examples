package;

import hxnet.tcp.Server;

class Main {
	public static function main() {
		#if neko
		trace('websocket quads neko service');
		#elseif cpp
		trace('websocket quads cpp service');
		#end

		var state = new QuadsState();
		var server = new Server(new QuadsServiceFactory(state), 54321, 'localhost');
		server.blocking = false;
		server.start();
	}
}
