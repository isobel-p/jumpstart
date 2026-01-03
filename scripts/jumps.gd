extends HBoxContainer
@onready var player := get_tree().get_first_node_in_group("player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_jumps():
	for i in get_child_count():
		get_child(i).visible = player.jumps > i	
