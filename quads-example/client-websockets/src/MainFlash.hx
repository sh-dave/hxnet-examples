package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.Lib;
import flash.ui.Keyboard;
import flash.utils.Timer;
import hxnet.tcp.Client;
import quads.QuadsProtocol.ClientInterface;

class MainFlash {
	static var keys = [false, false, false, false];

	static var myId : String;
	static var client : Client;
	static var protocol : QuadsClientService;

	static function main() {
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;

		initNetwork();

		stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDownHandler);
		stage.addEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);
		stage.addEventListener(Event.ENTER_FRAME, stage_enterFrameHandler);
		stage.addEventListener(MouseEvent.CLICK, stage_clickHandler);
	}

	static function clamp( value : Int, min : Int, max : Int ) : Int {
		return value < min ? min : value > max ? max : value;
	}

	static function initNetwork() {
		client = new Client();
		client.protocol = protocol = new QuadsClientService(
			new FlashLibrary(Lib.current.stage),
			function( id : String ) {
				myId = id;
			}
		);
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

	static function stage_enterFrameHandler( _ ) {
		var dx = 0;
		var dy = 0;

		if (keys[0]) dx -= 1;
		if (keys[1]) dx += 1;
		if (keys[2]) dy -= 1;
		if (keys[3]) dy += 1;

		move(dx, dy);
	}

	static function move( xdirection : Int, ydirection : Int ) {
		if (myId != null && (xdirection != 0 || ydirection != 0)) {
			protocol.sendCommand(ClientInterface.Move(myId, xdirection, ydirection));
		}
	}

	static var speed = 10;

	static function stage_clickHandler( _ ) {
	}

	static function stage_keyDownHandler( e : KeyboardEvent ) {
		switch (e.keyCode) {
			case Keyboard.LEFT: keys[0] = true;
			case Keyboard.RIGHT: keys[1] = true;
			case Keyboard.UP: keys[2] = true;
			case Keyboard.DOWN: keys[3] = true;
		}
	}

	static function stage_keyUpHandler( e : KeyboardEvent ) {
		switch (e.keyCode) {
			case Keyboard.LEFT: keys[0] = false;
			case Keyboard.RIGHT: keys[1] = false;
			case Keyboard.UP: keys[2] = false;
			case Keyboard.DOWN: keys[3] = false;
		}
	}
}
