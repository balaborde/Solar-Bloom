extends Node2D

const CARD_SCENE_PATH = "res://Scenes/card.tscn"

var player_hand_reference
var card_database_reference

var player_deck = ["Éolienne", "Champs", "École", "Éolienne"]

func _ready():
	player_deck.shuffle()
	player_hand_reference = $"../PlayerHand"
	card_database_reference = preload("res://Scripts/card_database.gd")
	$RichTextLabel.text = str(player_deck.size())
		

func draw_card():
	var card_drawn_name = player_deck[0]
	player_deck.erase(card_drawn_name)
	
	# If player drew the last card in the deck, disable the deck
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
		$RichTextLabel.visible = false
	
	$RichTextLabel.text = str(player_deck.size())
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	new_card.get_node("Attack").text = str(card_database_reference.CARDS[card_drawn_name][0])
	new_card.get_node("Health").text = str(card_database_reference.CARDS[card_drawn_name][1])
	new_card.get_node("CardImage").texture = load(str(card_database_reference.CARDS[card_drawn_name][2]))
	$"../CardManager".add_child(new_card)
	new_card.name = "Card " + str(player_deck.size()) 
	player_hand_reference.add_card_to_hand(new_card)
