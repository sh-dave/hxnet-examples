package;

interface Library {
	function createPlayer( id : String, x : Int, y : Int, color : Int ) : Void;
	function updatePlayerPosition( id : String, x : Int, y : Int ) : Void;
}
