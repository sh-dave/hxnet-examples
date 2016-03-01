package mphxnet;

import haxe.io.Bytes;
import hxnet.interfaces.Connection;

interface BinaryService {
	var onReceived(default, default) : Bytes -> Void;
	var onConnected(default, default) : Connection -> Void;

	function send( data : Bytes ) : Void;
	function broadcast( data : Bytes ) : Void;
}
