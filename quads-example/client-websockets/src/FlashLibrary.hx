package;

import flash.display.Sprite;
import flash.display.Stage;

// TODO (DK)
//		-z order
class FlashLibrary implements Library {
	var stage : Stage;
	var players : Map<String, QuadsPlayer> = new Map();

	public function new( stage : Stage ) {
		this.stage = stage;
	}

	public function createPlayer( id : String, x : Int, y : Int, color : Int ) {
		if (players.get(id) != null) {
			trace('player with id "${id}" is already registered');
			return;
		}

		players.set(id, new QuadsPlayer(stage, x, y, color));
	}

	public function updatePlayerPosition( id : String, x : Int, y : Int ) {
		var player = players.get(id);

		if (player != null) {
			player.sprite.x = x;
			player.sprite.y = y;
		}
	}
}

private class QuadsPlayer {
	public var sprite : Sprite;

	public function new( stage : Stage, x : Int, y : Int, color : Int ) {
		sprite = new Sprite();
		sprite.graphics.beginFill(color);
		sprite.graphics.drawRect(0, 0, 64, 64);
		sprite.graphics.endFill();
		stage.addChild(sprite);
		sprite.x = x;
		sprite.y = y;
	}
}
