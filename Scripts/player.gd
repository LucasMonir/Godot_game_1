extends "res://Scripts/EntityBase.gd"

func _ready():
	pass

func _process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
		$AnimatedSprite.animation = "Down"
	elif Input.is_action_pressed("ui_right"):
		velocity.x += speed
		$AnimatedSprite.animation = "Right"
	elif Input.is_action_pressed("ui_up"):
		velocity.y -= speed
		$AnimatedSprite.animation = "Up"
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		$AnimatedSprite.animation = "Left"
	if velocity.length() > 0:
		var info = move_and_collide(velocity * delta)
	if get_tree().get_nodes_in_group("Enemy").size() == 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")	

func _unhandled_input(ev):
	if (ev is InputEventKey and ev.scancode == KEY_SPACE):
		shoot()
		if not is_playing():
			var rand = floor(rand_range(0, 4))
			[$Shot, $Shot2, $Shot3, $Shot4, $Shot5][rand].play()
		

func is_playing():
	return $Shot.playing || $Shot2.playing || $Shot3.playing || $Shot4.playing || $Shot5.playing
		
func die():
	if $Death.playing == false:
			$Death.play()
	yield($Death, "finished")
	queue_free()
	get_tree().change_scene("res://Scenes/GameOver.tscn")	
	

