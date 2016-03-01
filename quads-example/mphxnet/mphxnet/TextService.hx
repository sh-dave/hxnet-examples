package mphxnet;

import hxnet.interfaces.Connection;

interface TextService {
	var onReceived(default, default) : String -> Void;
	var onConnected(default, default) : Connection -> Void;

	function send( data : String ) : Void;
	function broadcast( data : String ) : Void;
}
