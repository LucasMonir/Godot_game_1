extends "res://Scripts/EntityBase.gd"

var _autoshoot_timer = null
var rng = RandomNumberGenerator.new()
var current_dir: Vector2

func _ready():
	rng.randomize()
	_get_random_direction()
	_autoshoot_timer = Timer.new()
	add_child(_autoshoot_timer)
	_autoshoot_timer.connect("timeout", self, "_on_Authoshoot_Timer_timeout")
	_autoshoot_timer.set_wait_time(1.0)
	_autoshoot_timer.set_one_shot(false)
	_autoshoot_timer.start()

func _process(delta):
	velocity = current_dir * speed * 2

func _on_Authoshoot_Timer_timeout():
	shoot()

func _get_random_direction():
	var last_dir = current_dir
	rng.randomize()
	var directions = [Vector2.DOWN, Vector2.LEFT, Vector2.UP, Vector2.RIGHT]
	current_dir = directions[rng.randi_range(0, directions.size() - 1)]
	if current_dir == last_dir: _get_random_direction()
	if current_dir == Vector2.DOWN:
		$AnimatedSprite.animation = "Down"
	if current_dir == Vector2.LEFT:
		$AnimatedSprite.animation = "Left"
	if current_dir == Vector2.UP:
		$AnimatedSprite.animation = "Up"
	if current_dir == Vector2.RIGHT:
		$AnimatedSprite.animation = "Right"

func _on_Env_Collision_area_entered(area):
	_get_random_direction()
