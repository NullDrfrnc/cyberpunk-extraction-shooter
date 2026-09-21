@tool
class_name CounterResource extends Resource

## Name of the resource (eg. hp, mana, stamina)
@export var name : String = ""
## Maximum available amount of said resource
@export var maximum_amount : float = 0:
	set(value):
		if value < 0: push_error("Tried to set \"%s's\" maximum_amount to a negative value (%f), which is not allowed" % [name, value])
		else: maximum_amount = value

## The start value the counter should take, -1.0 will set it to the maximum_amount, any values higher then maximum_amount will be clamped to said value
@export var start_value : float = -1.0:
	set(value):
		if value > maximum_amount: push_warning("Tried to set \"%s's\" start_value to a value higher then maximum_amount (%f). If you want to set the start_value to the maximum_value at load, please use -1.0" % [name, value])
		else: start_value = value

func get_start_value() -> float:
	if start_value < 0.0: 
		return maximum_amount;
	return start_value;

#@export var sprite : Texture2D
