extends Area3D
signal collected

const ROT_SP = 2
@export var hud: CanvasLayer  # Add this to link the HUD UI

var collect_sound = preload("res://Assets/Sound/collect_sound_short.wav")
@onready var audio_player = $AudioStreamPlayer3D
# Rotate the chest every frame
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SP))

# When the player collides with the chest
func _on_body_entered(body: Node3D) -> void:
	audio_player.stream = collect_sound 
	audio_player.play()
	# Ensure only the player can collect the chest
	if body.name == "Player":
		Global.chests += 1  # Increase the chest count
		hud.get_node("ChestsLabel").text = str(Global.chests)  # Update HUD
		  # Play the sound
		# Check if the player has collected enough chests to win
		if Global.chests >= Global.NUM_CHESTS_TO_WIN:
			get_tree().change_scene_to_file("res://wongame_over.tscn")

		# Disable collisions to prevent re-collection
		set_collision_layer_value(3, false)
		set_collision_mask_value(1, false)

		# Remove the chest immediately
		queue_free()
