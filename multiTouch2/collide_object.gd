extends StaticBody3D

@onready var mesh_instance_3d = $MeshInstance3D
@onready var touching_indices_label = $touchingIndicesLabel
@onready var material = mesh_instance_3d.get_surface_override_material(0)

const OFF_COLOR = Color(0, 0, 0)
const ON_COLOR = Color(255, 255, 255)

var touchingIndices = {}
var was_touching = false

func _ready():
	changeColor(OFF_COLOR)
	
func changeColor(color):
	material.albedo_color = color
	mesh_instance_3d.set_surface_override_material(0, material)

func screenTouchUpdate(event, colliding:bool):
	var val = event.index
	
	if colliding:
		touchingIndices[val] = event.position
	else:
		touchingIndices.erase(val)
		
	var is_touching = not touchingIndices.is_empty()
	if was_touching != is_touching:
		if is_touching:#just pressed / entered
			changeColor(ON_COLOR)
		else:#just released / left
			changeColor(OFF_COLOR)
			
	was_touching = is_touching
	touching_indices_label.text = str(touchingIndices.keys())
