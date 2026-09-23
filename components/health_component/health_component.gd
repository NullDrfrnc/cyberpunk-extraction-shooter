class_name HealthComponent extends Node

@export var parent : Entity
@export var health_resource : CounterResource

var _counter_resource_component : CounterResourceComponent

signal damaged(parent : Entity, amount : float, source : Entity)
signal healed(parent : Entity, amount : float, source : Entity)
signal died(parent : Entity)

func _ready() -> void:
	if _counter_resource_component:
		self.remove_child(_counter_resource_component)
	
	_counter_resource_component = CounterResourceComponent.new()
	_counter_resource_component.resource = health_resource;
	_counter_resource_component.resource_depleted.connect(_died)
	
	self.add_child(_counter_resource_component);
	
	parent.damaged.connect(damage)
	parent.healed.connect(heal)

func _died(_resource_name : String) -> void:
	died.emit(parent)

func damage(amount : float, source : Entity) -> void:
	if _counter_resource_component:
		_counter_resource_component.remove_resource(amount)
		damaged.emit(parent, amount, source)

func heal(amount : float, source : Entity) -> void:
	if _counter_resource_component:
		_counter_resource_component.add_resource(amount)
		healed.emit(parent, amount, source)

func get_current_hp() -> float:
	if _counter_resource_component:
		return _counter_resource_component.current_resource_amount;
	
	push_error("_counter_resource_component has not been initialised properly")
	return 0.0;

func _physics_process(delta: float) -> void:
	print(get_current_hp())
