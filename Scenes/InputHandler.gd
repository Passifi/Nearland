extends Node2D
var clickMarker = null
var characters: Array
var cellsize: float = 64
const numberOfCells: float = 16
var currentSelectedUnit = null
var waitForRelease = false
enum {EnemyTurn, PickCharacter, ChoseAction, ChoseMovement, ChoseAttack }
var rng = RandomNumberGenerator.new()
var mode = PickCharacter
# Called when the node enters the scene tree for the first time.
func _ready():
	for c in get_children():
		if c.has_signal("chosePlayer"):
			c.chosePlayer.connect(setActiveCharacter)
		if c.has_signal("arrivedAtTarget"):
			c.arrivedAtTarget.connect(playerArrived)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setMovementTiles(currentPosition: Vector2):
	var tilemap: TileMap = $TileMap
	for i in range(5):
		tilemap.set_cell(1,Vector2i(currentPosition.x+i,currentPosition.y),3,Vector2i(0,0))
		tilemap.set_cell(1,Vector2i(currentPosition.x-i,currentPosition.y),3,Vector2i(0,0))
		tilemap.set_cell(1,Vector2i(currentPosition.x,currentPosition.y+i),3,Vector2i(0,0))
		tilemap.set_cell(1,Vector2i(currentPosition.x,currentPosition.y-i),3,Vector2i(0,0))
		tilemap.set_cell(1,Vector2i(currentPosition.x-i,currentPosition.y-i),3,Vector2i(0,0))
		tilemap.set_cell(1,Vector2i(currentPosition.x+i,currentPosition.y-i),3,Vector2i(0,0))
		tilemap.set_cell(1,Vector2i(currentPosition.x-i,currentPosition.y+i),3,Vector2i(0,0))
		tilemap.set_cell(1,Vector2i(currentPosition.x+i,currentPosition.y+i),3,Vector2i(0,0))

func setTarget(event):
			
			var target  = get_node("TileMap").local_to_map(event.position)
			if $TileMap.get_cell_source_id(1, target) != 3:
				return false
			var targetX:float = target.x * cellsize + cellsize/2;
			var targetY:float = target.y *cellsize + cellsize/2;
			var targets: Array[Vector2] = [Vector2(targetX,targetY)]
			currentSelectedUnit.setTargets(targets)
			return true
 
func setActiveCharacter(characterRef: Character, event):
	if mode == PickCharacter:
		$SelectionSFX.play()
		currentSelectedUnit = characterRef
		mode = ChoseMovement
		waitForRelease = true
		var target  = get_node("TileMap").local_to_map(event.position)
		setMovementTiles(target)
		
func _input(event):
		if event is InputEventMouseButton:
			if waitForRelease and !event.pressed:
				return
			else:
				waitForRelease = false
			if mode == ChoseMovement:
				if(!setTarget(event)):
					return					
				mode = PickCharacter
				$FootStepsSFX.play()
				$FootStepsSFX.set_pitch_scale(randf_range(0.9,1.05))
				currentSelectedUnit.deactivate()
				$TileMap.clear_layer(1)

func _on_playfield_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
	
func playerArrived():
	$FootStepsSFX.stop()
