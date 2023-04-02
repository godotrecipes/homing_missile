extends Area2D

@export var rotation_speed = PI
@export var cooldown = 0.5

var missile_scene = preload("res://missile.tscn")

var target = null
var can_shoot = true

@onready var muzzle = $Turret/Muzzle
@onready var flash = $Turret/Flash

func shoot():
	if can_shoot:
		var m = missile_scene.instantiate()
		get_tree().root.add_child(m)
		m.start(muzzle.global_transform, target)
		muzzle_flash()
		can_shoot = false
		await get_tree().create_timer(cooldown).timeout
		can_shoot = true

func muzzle_flash():
	flash.show()
	await get_tree().create_timer(0.1).timeout
	flash.hide()

func _process(delta):
	if target:
		$Turret.look_at(target.global_position)
		shoot()
		
func _on_body_entered(body):
	target = body

func _on_body_exited(body):
	if body == target:
		target = null
