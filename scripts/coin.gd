extends Area2D

@export var number: int = 1  # valor da moeda

var sequence_manager

func _ready():
	add_to_group("Coins")  # para ser encontrado pelo SequenceManager
	await get_tree().process_frame  # garante que tudo esteja carregado
	sequence_manager = get_node("/root/SequenceManager")
	$Label.text = str(number)

	# Define visibilidade com base na sequência
	visible = (number == sequence_manager.get_current_number())

func _on_body_entered(body):
	if number == sequence_manager.get_current_number():
		queue_free()  # remove a moeda coletada
		sequence_manager.advance()
