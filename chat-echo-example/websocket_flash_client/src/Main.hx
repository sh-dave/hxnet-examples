package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.KeyboardEvent;
import flash.events.TimerEvent;
import flash.Lib;
import flash.system.Security;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.utils.Timer;
import haxe.io.Bytes;
import hxnet.tcp.Client;

class Main {
	static function main() {
		//Security.allowDomain('*');
		//Security.allowInsecureDomain('*');
		//Security.loadPolicyFile('http://127.0.0.1:8082/crossdomain.xml');
		trace(Security.sandboxType);

		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;

		var format = new TextFormat();
		format.font = "Verdana";
		format.color = 0x000000;
		format.size = 10;
		//format.underline = true;

		var log = new TextField();
		log.width = stage.stageWidth - 1;
		log.height = stage.stageHeight - 64;
		log.defaultTextFormat = format;
		//log.text = 'abc\ndef\nghi\n';
		log.border = true;
		log.borderColor = 0x000000;

		stage.addChild(log);

		var input = new TextField();
		input.type = TextFieldType.INPUT;
		input.y = stage.stageHeight - 62;
		input.width = stage.stageWidth - 1;
		input.height = 60;
		input.defaultTextFormat = format;
		//input.text = 'type here';
		input.border = true;
		input.borderColor = 0x000000;

		var protocol = new common.ClientProtocol(
			function( text : String ) {
				log.text += '\n';
				log.text += 't> ${text}';
			},
			function( data : Bytes ) {
				log.text += '\n';
				log.text += 'b> ${data.toString()}';
			}
		);

		input.addEventListener(KeyboardEvent.KEY_DOWN, function( event : KeyboardEvent ) {
			switch (event.charCode) {
				case 13: {
					trace('sending "${input.text}"');
					protocol.sendText(input.text);
					input.text = '';
				}
			}
		});

		stage.addChild(input);

		var client = new Client();
		client.protocol = protocol;
		client.blocking = false;
		client.connect('localhost', 54321);

		var updateTimer = new Timer(1);
		updateTimer.addEventListener(TimerEvent.TIMER, function( _ ) {
			if (client != null) {
				client.update();
			}
		});

		updateTimer.start();
	}
}
