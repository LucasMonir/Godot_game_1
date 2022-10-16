extends "res://Scripts/Hitbox.gd"

export(int) var SPEED: int = 800


func _physics_process(delta):
	global_position += Vector2.RIGHT.rotated(rotation) * SPEED * delta
	
func destroy():
	queue_free()
	
func _on_Projectile_area_entered(area):
	destroy()
