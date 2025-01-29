extends Node3D

var case_scene = preload("res://case.tscn")
var grid_size = 10
var spacing = 2.0

func _ready():
	for x in range(grid_size):
		for z in range(grid_size):
			var pos = Vector3(x * spacing, 0, z * spacing)
			instCase(pos)

func instCase(pos):
	var new_case = case_scene.instantiate()
	new_case.position = pos
	add_child(new_case)
