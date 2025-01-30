extends Node2D

var type
var starting_position


func animate_card_to_position(new_position):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", new_position, 0.5)
