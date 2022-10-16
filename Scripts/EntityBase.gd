extends KinematicBody2D

const MAX_HP: int = 100
onready var PROJECTILE = preload("res://Scenes/Projectile.tscn")

export (int) var hp = MAX_HP
export (int) var speed: int = 200

var velocity: Vector2 = Vector2.ZERO
var pointing_angle: float = Vector2.DOWN.angle()
var last_non_zero_normalized_velocity: Vector2 = Vector2.DOWN
var can_shoot: bool = true
var _timer = null

func _ready():
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(.5)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()

func _physics_process(delta):
	move(delta)
	
func move(delta):
	velocity = move_and_slide(velocity)
	if velocity != Vector2.ZERO:
		last_non_zero_normalized_velocity = velocity.normalized()
		pointing_angle = velocity.normalized().angle()
		$CollisionShape2D.rotation = pointing_angle + deg2rad(90)
	
func die():
	queue_free()

func _on_Timer_timeout():
	can_shoot = true

func shoot():
	if not can_shoot: return
	var projectile = PROJECTILE.instance()
	projectile.position = position + (last_non_zero_normalized_velocity * 100)
	projectile.rotation = pointing_angle
	get_tree().current_scene.add_child(projectile)
	can_shoot = false


func _on_Hurtbox_area_entered(hitbox):
	var base_damage = hitbox.damage
	self.hp -= base_damage
	hitbox.destroy()
	print("current HP is:" + str(self.hp))
	if self.hp <= 0:
		die()

