class_name ResourceCounterComponent extends Node

signal resource_depleted(resource_name: String)
signal resource_changed(new_resource_amount: float, max_resource_amount: float, resource_name: String)
signal resource_reduced(amount: float, resource_name: String)

@export var _resource : CounterResource

var resource_name : String = "";
var max_resource_amount : float;
var start_filled : bool;

var current_resource_amount : float;

func _ready() -> void:
	resource_name = _resource.resource_name;
	max_resource_amount = _resource.maximum_amount;
	resource_name = _resource.resource_name;
	
	if max_resource_amount <= 0:
		push_error("[ERROR]: {} has a max value of {} which may not be allowed in a ResourceCounterComponent")
	
	if start_filled:
		current_resource_amount = max_resource_amount
	else:
		current_resource_amount = 0

func remove_resource(amount : float) -> void:
	if current_resource_amount <= 0 or amount <= 0:
		return
	
	current_resource_amount = max(current_resource_amount - amount, 0)
	resource_reduced.emit(amount, resource_name)
	resource_changed.emit(current_resource_amount, max_resource_amount, resource_name)
	
	if current_resource_amount <=0:
		resource_depleted.emit(resource_name)

func add_resource(amount : float) -> void:
	if amount <= 0:
		return
	
	current_resource_amount = min(current_resource_amount + amount, max_resource_amount)
	resource_changed.emit(current_resource_amount, max_resource_amount, resource_name)

func set_resource(amount : float) -> void:
	if amount <= 0:
		return
	
	current_resource_amount = clamp(amount, 0, max_resource_amount)
	resource_changed.emit(current_resource_amount, max_resource_amount, resource_name)
