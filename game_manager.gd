extends Node2D

const MAX_TURNS = 15

var current_turn = 1
var biodiversity_points = 0
var community_points = 0
var energy_points = 0

@onready var gauge = $Gauge

func calculate_score(player_id: int) -> float:
	return (
		biodiversity_points
		+ community_points
		+ energy_points
		) / 3

func next_turn() -> void:
	# Update energy, biodiversity and
	# community points using all the cards
	update_points()
	# Calculate total score
	update_general_score()
	if (current_turn < MAX_TURNS) :
		current_turn += 1
	else :
		end_game()

func update_points() -> void:
	# Update energy, biodiversity
	# and community points using
	# all the cards on the field
	pass

func update_general_score() -> void:
	var player1_score = calculate_score(1)
	# TODO: Do something of that score
	var player2_score = calculate_score(2)
	# Update players gauge
	update_players_gauge(player1_score, player2_score)

func update_players_gauge(p1_s: float, p2_s: float) -> void:
	var total_score = ceil(p1_s + p2_s)
	var p1_prct = (p1_s * 100) / total_score
	var p2_pcrt = (p2_s * 100) / total_score
	gauge.update_texture(p1_prct, p2_pcrt)

func end_game() -> void:
	for i in range(1, 15):
		next_turn()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
