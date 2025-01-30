extends Node2D

const MAX: int = 100
var p1: float = 50
var p2: float = 50

@onready var texture = $texture

func update_texture(p1_prct: float, p2_pcrt: float) -> void:
	p1 = p1_prct
	p2 = p2_pcrt
	texture.frame = round(p1)+1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
