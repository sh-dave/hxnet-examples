package quads;

import mphxnet.User;

class Player extends User {
	public var x : Int;
	public var y : Int;
	public var color : Int;

	public function new( x : Int, y : Int, color : Int ) {
		super();
		this.x = x;
		this.y = y;
		this.color = color;
	}
}
