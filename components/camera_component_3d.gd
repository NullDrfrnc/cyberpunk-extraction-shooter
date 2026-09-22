class_name CameraComponent3D extends Node3D

@export var player : Player

# Max y pivot in degrees
@export var max_y_pivot : float = 90.0

@export var mouse_sensitivity : float = 1.0

func _input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			player.rotate_y(-event.relative.x * (mouse_sensitivity / 1000))
			player.neck_pivot.rotate_x(-event.relative.y * (mouse_sensitivity / 1000))
			player.neck_pivot.rotation.x = clamp(player.neck_pivot.rotation.x, deg_to_rad(-max_y_pivot), deg_to_rad(max_y_pivot))
