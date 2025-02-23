extends CanvasLayer
@onready var timer = $GameTimer
@onready var timer_label = $TimerLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CoinsLabel.text=str(0)
	$ChestsLabel.text=str(0)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CoinsLabel.text = str(Global.coins)
	$ChestsLabel.text=str(Global.chests)
	timer_label.text = "Time: " + str(int(timer.time_left))  # Update timer display
func _on_game_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://losegame_over.tscn")  # Load Game Over scene
