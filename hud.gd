extends CanvasLayer

@onready var money_label = $MoneyLabel

func setup(level: Node2D):
	money_label.text = "$ " + str(level.money)
	level.money_changed.connect(_on_money_changed)

func _on_money_changed(new_amount: int):
	money_label.text = "$ " + str(new_amount)
