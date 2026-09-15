class_name MovementComponent3D extends Node3D

@export var player : Player

@export var max_speed : float = 10.0
@export var jump_force : float = 5.5

@export var ground_acceleration : float = 50.0
@export var ground_deceleration : float = 40.0

@export var air_acceleration : float = 6.0
@export var air_deceleration : float = 3.0

func _physics_process(delta : float) -> void:
	var input_direction : Vector3 = (player.transform.basis * _vec2_to_vec3(player.input)).normalized()
	
	var target_velocity = input_direction * max_speed
	
	player.velocity = player.velocity.move_toward(
		Vector3(target_velocity.x, player.velocity.y, target_velocity.z),
		_get_movement_modifier() * delta
	)
	
	if player.is_on_floor() and Input.is_action_pressed("mv_jump"):
		player.velocity.y += jump_force
		
	
	player.move_and_slide()

func _get_movement_modifier() -> float:
	var has_input : bool = player.input.length() > 0
	
	if player.is_on_floor():
		return ground_acceleration if has_input else ground_deceleration
	
	return air_acceleration if has_input else air_deceleration 

func _vec2_to_vec3(vec : Vector2) -> Vector3:
	return Vector3(vec.x, 0.0, vec.y)
