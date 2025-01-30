extends Node2D

signal hovered
signal hovered_off

var starting_position
var placed
var type

# Called when the node enters the scene tree for the first time.
func _ready():
	# All card must be a child of CardManager.
	get_parent().connect_card_signals(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_mouse_entered():
	emit_signal("hovered", self)


func _on_area_2d_mouse_exited():
	emit_signal("hovered_off", self)

func animate_card_to_position(new_position):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", new_position, 0.5)
