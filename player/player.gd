class_name Player extends CharacterBody3D

@export var neck_pivot : Node3D

var input : Vector2 = Vector2.ZERO

# Potential signal coupling or values would go through here

func _physics_process(_delta : float) -> void:
	input = Input.get_vector("mv_left", "mv_right", "mv_forward", "mv_backward")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
