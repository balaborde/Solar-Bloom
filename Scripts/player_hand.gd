extends Node2D

const CARD_WIDTH = 300
const HAND_Y_POSITION = 890
var player_hand = []
var center_screen_x


func _ready():
	center_screen_x = get_viewport_rect().size.x / 2


func add_card_to_hand(card):
	if card not in player_hand:
		player_hand.insert(0, card)
		update_hand_positions()
	else: 
		card.animate_card_to_position(card.starting_position)


func update_hand_positions():
	for i in range(player_hand.size()):
		# Get new card position based on index.
		var new_position = Vector2(calculate_card_position(i), HAND_Y_POSITION)
		var card = player_hand[i]
		card.starting_position = new_position
		card.animate_card_to_position(new_position)


func calculate_card_position(index):
	var total_width = (player_hand.size() -1) * CARD_WIDTH
	var x_offset = center_screen_x + index * CARD_WIDTH - total_width / 2
	return x_offset


func remove_card_from_hand(card):
	if card in player_hand:
		player_hand.erase(card)
		update_hand_positions()
