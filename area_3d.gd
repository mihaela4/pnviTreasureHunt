extends Area3D

signal collected

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":  # Check if it's the player
		emit_signal("collected")
		queue_free()  # Remove the chest
