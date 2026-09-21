class_name CounterResourceComponent extends Node

signal resource_depleted(resource_name : String)
signal resource_changed(new_resource_amount: float, max_resource_amount: float, resource_name: String)
signal resource_reduced(amount: float, resource_name: String)

@export var resource : CounterResource

var current_resource_amount : float;

func _ready() -> void:
	current_resource_amount = resource.get_start_value()

func remove_resource(amount : float) -> void:
	if current_resource_amount <= 0 or amount <= 0:
		return
	
	current_resource_amount = max(current_resource_amount - amount, 0)
	resource_reduced.emit(amount, resource.name)
	resource_changed.emit(current_resource_amount, resource.maximum_amount, resource.name)
	
	if current_resource_amount <=0:
		resource_depleted.emit(resource.name)

func add_resource(amount : float) -> void:
	if amount <= 0:
		return
	
	current_resource_amount = min(current_resource_amount + amount, resource.maximum_amount)
	resource_changed.emit(current_resource_amount, resource.maximum_amount, resource.name)

func set_resource(amount : float) -> void:
	if amount <= 0:
		return
	
	current_resource_amount = clamp(amount, 0, resource.maximum_amount)
	resource_changed.emit(current_resource_amount, resource.maximum_amount, resource.name)
