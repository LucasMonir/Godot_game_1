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
	
func _unhandled_input(ev):
	if (ev is InputEventKey and ev.scancode == KEY_SPACE):
		shoot()

func die():
	queue_free()
