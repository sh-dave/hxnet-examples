package;

import haxe.io.Bytes;
import js.Browser;
import js.html.ButtonElement;
import js.html.InputElement;
import js.html.TextAreaElement;

class Main {
	static var client : hxnet.ws.Client;

	static function main() {
		var log : TextAreaElement = cast Browser.document.getElementById('logarea');
		var input : InputElement = cast Browser.document.getElementById('inputline');
		var closeButton : ButtonElement = cast Browser.document.getElementById('closeConnection');

		closeButton.onclick = function( _ ) {
			client.close();
		}

		input.onkeypress = function( event ) {
			if (event.which == 10 || event.which == 13) {
				client.sendText(input.value);
				input.value = '';
			}
		}

		client = new hxnet.ws.Client(
			function( text : String ) {
				log.value += 't> ${text}\n';
				log.scrollTop = log.scrollHeight;
			},
			function( data : Bytes ) {
				log.value += 'b> ${data.toString()}\n';
				log.scrollTop = log.scrollHeight;
			}
		);

		//client.protocol = protocol;
		//client.blocking = false;
		client.connect('localhost', 54321);

		Browser.window.requestAnimationFrame(function( Float ) {
			if (client != null) {
				client.update();
			}
		});
	}
}
