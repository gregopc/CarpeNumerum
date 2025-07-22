extends Node

var current_index = 0
var sequence = [1, 2, 3, 4, 5]  # pode ser qualquer sequência

var hud_label: Label = null  # referência ao label da HUD

func _ready():
	# Tenta encontrar o label na árvore global
	await get_tree().process_frame  # aguarda a cena carregar
	var main_node = get_tree().get_root().get_node("Game")
	if main_node:
		hud_label = main_node.get_node("HUD/SequenceLabel")
	update_visible_coins()
	update_hud()

func get_current_number():
	return sequence[current_index]

func advance():
	current_index += 1
	if current_index < sequence.size():
		update_visible_coins()
		update_hud()
	else:
		print("Sequência concluída!")
		if hud_label:
			hud_label.text = "Parabéns! Sequência concluída."

func update_visible_coins():
	for coin in get_tree().get_nodes_in_group("Coins"):
		coin.visible = (coin.number == get_current_number())

func update_hud():
	if hud_label:
		hud_label.text = "Número atual: " + str(get_current_number())
