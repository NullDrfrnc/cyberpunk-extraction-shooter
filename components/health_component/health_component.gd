class_name HealthComponent extends Node

@export var parent : Node3D
@export var health_resource : CounterResource

var _counter_resource_component : CounterResourceComponent

signal damaged(damaged_entity : Node3D, amount : float)
signal healed(healed_entity : Node3D, amount : float)
signal died(dead_entity : Node3D)

func _ready() -> void:
	if _counter_resource_component:
		self.remove_child(_counter_resource_component)
	
	_counter_resource_component = CounterResourceComponent.new()
	_counter_resource_component.resource = health_resource;
	
	_counter_resource_component.resource_depleted.connect(_died)
	
	self.add_child(_counter_resource_component);

func _died() -> void:
	died.emit(parent)

func damage(amount : float) -> void:
	if _counter_resource_component:
		_counter_resource_component.remove_resource(amount)
		damaged.emit(parent, amount)

func heal(amount : float) -> void:
	if _counter_resource_component:
		_counter_resource_component.add_resource(amount)
		healed.emit(parent, amount)

func get_current_hp() -> float:
	if _counter_resource_component:
		return _counter_resource_component.current_resource_amount;
	
	push_error("_counter_resource_component has not been initialised properly")
	return 0.0;
