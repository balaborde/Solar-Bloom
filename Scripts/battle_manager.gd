extends Node

const SMALL_CARD_SCALE = 1

var playerBio = 10
var playerSocial = 10
var playerEnergy = 10

var enemyBio = 10
var enemySocial = 10
var enemyEnergy = 10

var battle_timer
var countdown_label  # Reference to the RichTextLabel
var countdown_img
var countdown_time = 30  # Set initial countdown value
var empty_slots = []

const MAX: int = 100
var p1: float = 50
var p2: float = 50

@onready var texture = $"../Gauge/texture"

func update_texture(p1_prct: float, p2_pcrt: float) -> void:
	p1 = p1_prct
	p2 = p2_pcrt
	texture.frame = round(p1)+1

func _ready() -> void:
	# Get the label reference
	countdown_label = $"../BattleTimer/TimeLabel"  # Update with the correct path
	countdown_img = $"../BattleTimer/Clock"

	# Initialize player and enemy resources
	_update_resource_labels()

	update_texture(50,50)
	
	# Setup the battle timer
	battle_timer = $"../BattleTimer"
	battle_timer.one_shot = false  # Set to false so it repeats every second
	battle_timer.wait_time = 1.0

	# Ensure the function is connected to the timer's timeout signal
	if not battle_timer.timeout.is_connected(_on_battle_timer_timeout):
		battle_timer.timeout.connect(_on_battle_timer_timeout)

	fill_empty_slots()

	# Start the countdown
	start_countdown()

func _update_resource_labels() -> void:
	# Player labels
	$"/root/Main/PlayerRessources/SocialLabel".text = str(playerSocial)
	$"/root/Main/PlayerRessources/BioLabel".text = str(playerBio)
	$"/root/Main/PlayerRessources/EnergyLabel".text = str(playerEnergy)

	# Enemy labels
	$"/root/Main/EnemyRessources/SocialLabel".text = str(enemySocial)
	$"/root/Main/EnemyRessources/BioLabel".text = str(enemyBio)
	$"/root/Main/EnemyRessources/EnergyLabel".text = str(enemyEnergy)

func fill_empty_slots() -> void:
	empty_slots.append($"../CardSlots/CardSlot")
	for i in range(2, 61):
		empty_slots.append(get_node("../CardSlots/CardSlot" + str(i)))

func start_countdown() -> void:
	countdown_time = 30  # Reset countdown
	update_countdown_label()
	battle_timer.start()  # Start the repeating timer

func update_countdown_label() -> void:
	countdown_label.text = str(countdown_time)

func _on_battle_timer_timeout() -> void:
	countdown_time -= 1
	update_countdown_label()

	if countdown_time <= 0:
		battle_timer.stop()  # Stop the countdown
		countdown_label.text = "Time's up!"
		_on_end_turn_button_pressed()

func _on_end_turn_button_pressed() -> void:
	battle_timer.stop()  # Stop countdown when ending turn
	opponent_turn()

func opponent_turn() -> void:
	$"../EndTurnButton".disabled = true
	$"../EndTurnButton".visible = false
	
	countdown_img.visible = false
	countdown_label.visible = false
	
	if $"../EnemyDeck".enemy_deck.size() != 0:
		$"../EnemyDeck".draw_card()
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
	
	battle_timer.start()
	await battle_timer.timeout
	
	end_opponent_turn()


	
	
@onready var gauge = $"../Gauge"  


func update_players_gauge(playerBio: float, playerEnergy: float, playerSocial: float, enemyBio: float, enemyEnergy: float, enemySocial: float) -> void:
	var player_score = playerBio + playerEnergy + playerSocial
	var enemy_score = enemyBio + enemyEnergy + enemySocial
	
	var total_score = ceil(player_score + enemy_score)
	
	var player_prct = 0 if total_score == 0 else (player_score * 100) / total_score
	var enemy_prct = 0 if total_score == 0 else (enemy_score * 100) / total_score
	update_texture(player_prct, enemy_prct)

func end_opponent_turn() -> void:
	countdown_label.visible = true
	countdown_img.visible = true
	
		
	playerBio += 4
	playerEnergy -= 1
	playerSocial += 3
	
	enemyBio -= 1
	enemyEnergy += 2
	enemySocial -= 1
	
	update_players_gauge(playerBio, playerEnergy, playerSocial, enemyBio, enemyEnergy, enemySocial)
	_update_resource_labels()
	
	
	
	
	$"../Deck".reset_draw()
	$"../EndTurnButton".disabled = false
	$"../EndTurnButton".visible = true
	
	
	
	start_countdown()  # Restart countdown for the player's turn
	
	
	
	
	
	
	
	
