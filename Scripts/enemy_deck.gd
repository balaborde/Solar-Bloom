extends Node2D

const CARD_SCENE_PATH = "res://Scenes/enemy_card.tscn"
const STARTING_HAND_SIZE = 3

var card_database_reference

var enemy_deck = [
	"Éolienne", "Éolienne", 
	"Vents Violents", "Vents Violents", 
	"Hacktivisme Écologique", "Hacktivisme Écologique", 
	"Floraison Exponentielle", "Floraison Exponentielle", 
	"Pluie", "Pluie", 
	"Séisme", "Séisme", 
	"Maison", "Maison", 
	"Générateur de Nuage", "Générateur de Nuage", 
	"Hôpital", "Hôpital", 
	"Invasion de Parasites", "Invasion de Parasites", 
	"Ferme Aquaponique", "Ferme Aquaponique", 
	"Réserve Naturelle", "Réserve Naturelle", 
	"Panneau Solaire", "Panneau Solaire", 
	"Base Solaire", "Base Solaire", 
	"Petit Labo", "Petit Labo", 
	"Éco Labo", "Éco Labo", 
	"Colonie Nomade", "Colonie Nomade", 
	"Barrage", "Barrage", 
	"École", "École", 
	"Lycée", "Lycée", 
	"Université", "Université"
]

func _ready():
	enemy_deck.shuffle()
	card_database_reference = preload("res://Scripts/card_database.gd")
	$RichTextLabel.text = str(enemy_deck.size())
	for i in range(STARTING_HAND_SIZE):
		draw_card()

func draw_card():
	var card_drawn_name = enemy_deck[0]
	enemy_deck.erase(card_drawn_name)
	
	# If player drew the last card in the deck, disable the deck
	if enemy_deck.size() == 0:
		$Sprite2D.visible = false
		$RichTextLabel.visible = false
	
	$RichTextLabel.text = str(enemy_deck.size())
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	new_card.get_node("CardImage").texture = load("res://Assets/cards/" + card_database_reference.CARDS[card_drawn_name][0] + ".png")
	new_card.type = card_database_reference.CARDS[card_drawn_name][1]
	$"../CardManager".add_child(new_card)
	new_card.name = "Card " + str(enemy_deck.size())
	$"../EnemyHand".add_card_to_hand(new_card)
