extends Node2D

const CARD_SCENE_PATH = "res://Scenes/card.tscn"

var player_hand_reference

var player_deck = ["Éolienne", "Éolienne", "Éolienne"]

func _ready():
	player_hand_reference = $"../PlayerHand"
	$RichTextLabel.text = str(player_deck.size())
		

func draw_card():
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)
	
	# If player drew the last card in the deck, disable the deck
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
		$RichTextLabel.visible = false
	
	$RichTextLabel.text = str(player_deck.size())
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	$"../CardManager".add_child(new_card)
	new_card.name = "Card " + str(player_deck.size()) 
	player_hand_reference.add_card_to_hand(new_card)
