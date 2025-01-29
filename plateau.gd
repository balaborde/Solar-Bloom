extends Node3D


var case = preload("res://case.tscn")

func _ready():
	instCase(pos)




func instCase(pos):
	var case = case.instantiate()
	add_child(case)
