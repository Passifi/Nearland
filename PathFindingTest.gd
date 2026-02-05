@tool 
extends EditorScript

func _run():
	var pathFinder = PathFinder.new() 
	var nodes = pathFinder.calculateValidTiles(Vector2(2,2),null,20)
	
