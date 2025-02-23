extends Area3D

signal collected

# Rotation speed for the coin
const ROT_SPEED = 2
@export var hud : CanvasLayer

var collect_sound = preload("res://Assets/Sound/collect_sound_short.wav")
@onready var audio_player = $AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # No functionality needed here currently.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))

# Called when the player collides with the coin.
func _on_body_entered(body: Node3D) -> void:
	Global.coins += 1
	hud.get_node("CoinsLabel").text = str(Global.coins)
	
	if Global.coins >= Global.NUM_COINS_TO_WIN:
		get_tree().change_scene_to_file("res://wongame_over.tscn")
	
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	$AnimationPlayer.play("bounce")
	audio_player.stream = collect_sound 
	audio_player.play()  

# Called when the animation finishes.
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	call_deferred("queue_free")
