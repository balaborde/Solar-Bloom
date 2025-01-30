extends Node2D

const HAND_COUNT = 4
const CARD_SCENE_PATH = "res://Scenes/card.tscn"

var player_hand_reference

var player_deck = ["Éolienne"]

func _ready():
	player_hand_reference = $"../PlayerHand"
		
	var card_scene = preload(CARD_SCENE_PATH)
	for i in range(HAND_COUNT):
		var new_card = card_scene.instantiate()
		$"../CardManager".add_child(new_card)
		new_card.name = "Card " + str(i) 
		player_hand_reference.add_card_to_hand(new_card)
	
func draw_card():
	print("drawing card")
