extends Node2D

const CARD_WIDTH = 140
const HAND_Y_POSITION = -505

var enemy_hand = []

func _ready():
	pass

func add_card_to_hand(card):
	if card not in enemy_hand:
		enemy_hand.insert(0, card)
		update_hand_positions()
	else: 
		card.animate_card_to_position(card.starting_position)


func update_hand_positions():
	for i in range(enemy_hand.size()):
		# Get new card position based on index.
		var new_position = Vector2(calculate_card_position(i), HAND_Y_POSITION)
		var card = enemy_hand[i]
		card.starting_position = new_position
		card.animate_card_to_position(new_position)


func calculate_card_position(index):
	var total_width = (enemy_hand.size() -1) * CARD_WIDTH
	var x_offset = - index * CARD_WIDTH + total_width / 2
	return x_offset


func remove_card_from_hand(card):
	if card in enemy_hand:
		enemy_hand.erase(card)
		update_hand_positions()
