extends Node3D

@onready var main_camera = $"../MainCamera"


func getIntersect(pos):
	var worldspace = get_world_3d().direct_space_state
	var start = main_camera.project_ray_origin(pos)
	var end = main_camera.project_position(pos, 1000)
	var parameters = PhysicsRayQueryParameters3D.create(start, end)
	var result = worldspace.intersect_ray(parameters)
	
	return result
	
func _input(event):
	#mouse debug
	if event is InputEventMouse:
		if event.is_pressed():
			print(getIntersect(event.position))
	
	elif event is InputEventScreenTouch or event is InputEventScreenDrag:
		get_viewport().set_input_as_handled()
		var collider = null
		if event is InputEventScreenTouch and event.is_released():#touch released
			collider = null
		else:#touch pressed / entered
			var intersect = getIntersect(event.position)
			if not intersect.is_empty():
				collider = intersect["collider"]
				
			
		for collideObject in get_children():
			var colliding = collider == collideObject
			collideObject.screenTouchUpdate(event, colliding)
