package mphxnet.utility;

class Guid {
	// TODO (DK) generate real guid's
	public static function generate() : String {
		return '${StringTools.hex(Math.floor(0xffffff * Math.random()))}-${StringTools.hex(Math.floor(0xffffff * Math.random()))}-${StringTools.hex(Math.floor(0xffffff * Math.random()))}-${StringTools.hex(Math.floor(0xffffff * Math.random()))}';
	}
}
