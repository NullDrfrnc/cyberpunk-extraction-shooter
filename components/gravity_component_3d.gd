class_name GravityComponent3D extends Node3D

@export var body : CharacterBody3D

func _physics_process(delta: float) -> void:
	if !body.is_on_floor():
		body.velocity.y -= Constants.gravity * delta
