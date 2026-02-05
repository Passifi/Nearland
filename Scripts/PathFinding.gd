class_name PathFinder
class TileNode:
	var distance
	var predecessor 
	var coordinates: Vector2 
	func _init(dist, pred, coord):
		distance = dist
		predecessor = pred
		coordinates = coord 

func _init():
	pass

var tiles = [0,0,0,0,
	1,1,1,1,
	2,2,2,2,
	3,3,3,3]
	
func getNodeFromCoord(coord: Vector2, former: TileNode=null):
	var distanceBase = tiles[coord.x + coord.y*4]
	return TileNode.new(distanceBase,former,coord)
	
func calculateValidTiles(startingPoint: Vector2,tilemap: TileMap,distance: float):
		
		var visitedTiles : Dictionary
		var tileQueue: Array
		tileQueue.push_back(TileNode.new(tiles[startingPoint.x + startingPoint.y *4 ],null,startingPoint))
		while(!tileQueue.is_empty()):
			var currentNode: TileNode = tileQueue.pop_front()
			var x = currentNode.coordinates.x
			var y = currentNode.coordinates.y
			visitedTiles[Vector2(x,y)] = Vector2(x,y)
			if (distance <= 0): 
				return visitedTiles.values()
			distance -= currentNode.distance
			if(x > 0 and !visitedTiles.has(Vector2(x-1,y))):
				tileQueue.push_back(getNodeFromCoord(Vector2(x-1,y),currentNode))
			if(x < 3 and !visitedTiles.has(Vector2(x+1,y))):
				tileQueue.push_back(getNodeFromCoord(Vector2(x+1,y),currentNode))
			if(y > 0 and !visitedTiles.has(Vector2(x,y-1))):
				tileQueue.push_back(getNodeFromCoord(Vector2(x,y-1),currentNode))
			if(y < 3 and !visitedTiles.has(Vector2(x,y+1))):
				tileQueue.push_back(getNodeFromCoord(Vector2(x,y+1),currentNode))
		return visitedTiles.values()
		
		

# Called when the node enters the scene tree for the first time.
