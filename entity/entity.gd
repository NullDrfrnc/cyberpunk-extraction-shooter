class_name Entity extends CharacterBody3D

signal damaged(amount : float, source : Node)
signal healed(amount : float, source : Node)

func damage(amount : float, source : Node) -> void:
	damaged.emit(amount, self)

func heal(amount : float, source : Node) -> void:
	healed.emit(amount, self)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
