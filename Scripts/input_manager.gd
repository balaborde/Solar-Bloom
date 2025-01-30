extends Node2D

signal left_mouse_button_clicked
signal left_mouse_button_released

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_DECK  = 3
const COLLISION_MASK_SLOT = 2

var card_manager_reference
var deck_reference

func _ready():
	card_manager_reference = $"../CardManager"
	deck_reference = $"../Deck"
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			emit_signal("left_mouse_button_clicked")
			raycast_at_cursor()
		else:
			emit_signal("left_mouse_button_released")

#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.is_pressed():
			#var card = raycast_check_for_card()
			#if card:
				#start_drag(card)
		#else:
			#if card_being_dragged:
				#finish_drag()


func raycast_at_cursor():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		var result_collection_mask = result[0].collider.collision_mask
		
		# Card clicked.
		if result_collection_mask == COLLISION_MASK_CARD:
			var card_found = result[0].collider.get_parent()
			if card_found:
				card_manager_reference.start_drag(card_found)
				
		# Deck clicked.
		elif result_collection_mask == COLLISION_MASK_DECK:
			deck_reference.draw_card()
		# Slot clicked.
		#elif result_collection_mask == COLLISION_MASK_SLOT:
		#	pass
		else:
			card_manager_reference.finish_drag()
