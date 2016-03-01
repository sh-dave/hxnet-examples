package mphxnet;

import mphxnet.utility.Guid;

class User {
	public var id(default, null) : String;

	public function new() {
		id = Guid.generate();
	}
}
