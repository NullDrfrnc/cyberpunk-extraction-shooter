class_name MovementComponent3D extends Node3D

@export var player : Player

@export var max_speed : float = 240

@export var ground_acceleration : float = 96
@export var ground_deceleration : float = 128

@export var air_acceleration : float = 24
@export var air_deceleration : float = 32

func _physics_process(delta : float) -> void:
	var move_direction = (_vec2_to_vec3(player.input) * player.transform.basis).normalized()
	
	var target_velocity = move_direction * max_speed
	
	player.velocity = player.velocity.move_toward(
		Vector3(target_velocity.x, player.velocity.y, target_velocity.z),
		_get_movement_modifier() * delta
	)
	
	player.move_and_slide()

func _get_movement_modifier() -> float:
	var has_input : bool = player.input.length() > 0
	
	if player.is_on_floor():
		return ground_acceleration if has_input else ground_deceleration
	
	return air_acceleration if has_input else air_deceleration 

func _vec2_to_vec3(vec : Vector2) -> Vector3:
	return Vector3(vec.x, 0.0, vec.y)
