package;

#if cpp
import cpp.vm.Thread;
#end
#if neko
import neko.vm.Thread;
#end

import haxe.io.Bytes;
import hxnet.protocols.WebSocket;
import hxnet.tcp.Client;

class Main {
	public static function main() {
		var client = new Client();

		var protocol = new common.ClientProtocol(
			function( text : String ) {
				Sys.println('t> ${text}');
			},
			function( data : Bytes ) {
				Sys.println('b> ${data.toString()}');
			}
		);

		client.protocol = protocol;
		client.connect('localhost', 54321);
		client.blocking = false;

		var line = '';

		trace('client - type and press [enter] to send, "q" to quit');

		var t = Thread.create(function() {
			while (true) {
				if (client != null) {
					client.update();
				}
			}
		});

		while (true) {
			var line = Sys.stdin().readLine();

			switch (line) {
				case 'q': {
					client.close();
					client = null;
					return;
				}
				default: {
					protocol.sendText(line);
				}
			}
		}
	}
}
