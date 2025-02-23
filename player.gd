extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 12
var fall_sound = preload("res://Assets/Sound/f.wav")  # Load fall sound
@onready var audio_player = $AudioStreamPlayer3D  # Ensure the Player has this node

var xform: Transform3D


func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Play Robot Animations:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimationPlayer.play("jump")
	elif is_on_floor() and input_dir != Vector2.ZERO:
		$AnimationPlayer.play("run")
	elif is_on_floor() and input_dir == Vector2.ZERO:
		$AnimationPlayer.play("idle")


	
	if Input.is_action_just_pressed("cam_left"):
		$Camera_Controller.rotate_y(deg_to_rad(-30))
	if Input.is_action_just_pressed("cam_right"):
		$Camera_Controller.rotate_y(deg_to_rad(30))
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: Vector3 = ($Camera_Controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#za rotiranje na liceto
	if input_dir !=Vector2(0,0):
		$Armature.rotation_degrees.y = $Camera_Controller.rotation_degrees.y - rad_to_deg(input_dir.angle()) - 90

	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	$Camera_Controller.position= lerp($Camera_Controller.position, position, 0.15)
	


func _on_fall_zone_body_entered(body: Node3D) -> void:
	audio_player.stream = fall_sound
	audio_player.play()
	await get_tree().create_timer(0.8).timeout
	get_tree().change_scene_to_file("res://losegame_over.tscn")
