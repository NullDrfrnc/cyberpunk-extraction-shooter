extends Area3D

@export var heal : float = 1

func _physics_process(delta: float) -> void:
		for body : Node3D in get_overlapping_bodies():
			if body is Entity:
				body.heal(heal * delta, self)
