extends Node2D

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_CARD_SLOT = 2

var card_being_dragged
var screen_size
var is_hovering_on_card

var player_hand_reference
var input_manager_reference

func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_hand_reference = $"../PlayerHand"
	#input_manager_reference = $"../InputManager"
	#$"../InputManager".connect("left_mouse_button_clicked", on_left_mouse_button_clicked())
	#$"../InputManager".connect("left_mouse_button_released", on_left_mouse_button_released())


func on_left_mouse_button_clicked():
	pass
	

func on_left_mouse_button_released():
	pass
	
	
func _process(delta: float) -> void:
	if card_being_dragged and screen_size and screen_size.x and screen_size.y:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = Vector2(clamp(mouse_pos.x, -screen_size.x, screen_size.x), clamp(mouse_pos.y, -screen_size.y, screen_size.y))


func start_drag(card):
	card_being_dragged = card
	card.scale = Vector2(1, 1)

func finish_drag():
	
	card_being_dragged.scale = Vector2(1.05, 1.05)
		
	var card_slot_found = raycast_check_for_card_slot()
	# Card dropped in empty card slot.
	if card_slot_found and not card_slot_found.card_in_slot:
		player_hand_reference.remove_card_from_hand(card_being_dragged)
		card_being_dragged.position = card_slot_found.position
		card_being_dragged.get_node("Area2D/CollisionShape2D").disabled = true
		card_slot_found.card_in_slot = true
	
	else:
		# card_being_dragged.animate_card_to_position(card_being_dragged.starting_position)
		player_hand_reference.add_card_to_hand(card_being_dragged)
	
	card_being_dragged = null

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		# return result[0].collider.get_parent()
		return get_card_with_highest_z_index(result)
	return null

func raycast_check_for_card_slot():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD_SLOT
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		print(result)
		return result[0].collider.get_parent()
	return null
	
func get_card_with_highest_z_index(cards):
	# Assume the first card in cards array has the highest z index.
	var highest_z_card = cards[0].collider.get_parent()
	var highest_z_index = highest_z_card.z_index
	
	# Loop through the rest of the cards checking for a higher z index.
	for i in range(1, cards.size()):
		var current_card = cards[1].collider.get_parent()
		if current_card.z_index > highest_z_index:
			highest_z_card = current_card
			highest_z_index = current_card.z_index
	return highest_z_card

func connect_card_signals(card): 
	card.connect("hovered", on_card_hovered)
	card.connect("hovered_off", on_card_hovered_off)

func on_card_hovered(card):
	if !is_hovering_on_card:
		is_hovering_on_card = true
	highlight_card(card, true)

func on_card_hovered_off(card):
	if !card_being_dragged:
		highlight_card(card, false)
		# Check if hovered off card straight on to another card
		var new_card_hovered = raycast_check_for_card()
		if new_card_hovered:
			highlight_card(new_card_hovered, true)
		else:
			is_hovering_on_card = false

func highlight_card(card, hovered):
	if hovered:
		card.scale = Vector2(1.05, 1.05)
		card.z_index = 2
	else:
		card.scale = Vector2(1, 1)
		card.z_index = 1
