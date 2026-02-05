class_name Character
extends Node2D

var attributes: UnitData 

var targets: Array[Vector2] 
var isMoving = false
var currentTargetIndex = 0
@export var stepSize = 450.0
signal chosePlayer
var isActive = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isMoving:
		moveToTarget(delta)
	pass


func moveToTarget(delta):
			var currentTarget = targets[currentTargetIndex]
			if position.x == currentTarget.x:
				position.y += sign(currentTarget.y - position.y)*stepSize*delta	
				if abs(position.y-currentTarget.y) < stepSize*delta:
					position.y = currentTarget.y  
			else:
				position.x += sign(currentTarget.x - position.x)*stepSize*delta	
				if abs(position.x-currentTarget.x) < stepSize*delta:
					position.x = currentTarget.x  
			if position.x == currentTarget.x && position.y == currentTarget.y:
				currentTargetIndex+=1
				if currentTargetIndex == targets.size():
					isMoving=false 
					
					
func setTargets(newTargets: Array[Vector2]):
	isMoving = true 
	targets = newTargets
	currentTargetIndex = 0


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("chosePlayer",self,event)
		isActive = true;
		$Sprite2D.material.set_shader_parameter("showOutline",true);

func deactivate():
		$Sprite2D.material.set_shader_parameter("showOutline",false);
	
