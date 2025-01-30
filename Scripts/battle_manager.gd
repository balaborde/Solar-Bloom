extends Node

const SMALL_CARD_SCALE = 1

var battle_timer
var empty_slots = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	battle_timer = $"../BattleTimer"
	battle_timer.one_shot = true
	battle_timer.wait_time = 1.0
	fill_empty_slots()

func fill_empty_slots() -> void:
	empty_slots.append($"../CardSlots/CardSlot")
	for i in range(2, 61):
		empty_slots.append(get_node("../CardSlots/CardSlot" + str(i)))

func _on_end_turn_button_pressed() -> void:
	opponent_turn()

func opponent_turn() -> void:
	$"../EndTurnButton".disabled = true
	$"../EndTurnButton".visible = false
	
	if $"../EnemyDeck".enemy_deck.size() != 0:
		$"../EnemyDeck".draw_card()
		# Wait 1 second
		battle_timer.start()
		await battle_timer.timeout
	
	# Check if any slot is available
	if empty_slots.size() == 0:
		end_opponent_turn()
		return
	
	# Play the card in hard on the far right
	var enemy_hand = $"../EnemyHand".enemy_hand
	if enemy_hand.size() == 0:
		end_opponent_turn()
		return
	var random_slot = empty_slots[randi_range(0, empty_slots.size()-1)]
	var card_in_slot_this_turn = false
	while random_slot.card_in_slot:
		empty_slots.erase(random_slot)
		random_slot = empty_slots[randi_range(0, empty_slots.size()-1)]
		card_in_slot_this_turn = true
	if !card_in_slot_this_turn:
		empty_slots.erase(random_slot)
	else:
		card_in_slot_this_turn = false
	
	var played_card = enemy_hand[0]
	for card in enemy_hand:
		if card.type == "B":
			played_card = card
			break
	
	played_card.animate_card_to_position(random_slot.position)
	var tween = get_tree().create_tween()
	tween.tween_property(played_card, "scale", random_slot.scale, 0.5)
	played_card.get_node("AnimationPlayer").play("card_flip")
	
	# Remove card from the enemy's hand
	$"../EnemyHand".remove_card_from_hand(played_card)
	
	# Wait 1 second
	battle_timer.start()
	await battle_timer.timeout
	
	end_opponent_turn()

func end_opponent_turn() -> void:
	$"../Deck".reset_draw()
	$"../EndTurnButton".disabled = false
	$"../EndTurnButton".visible = true
