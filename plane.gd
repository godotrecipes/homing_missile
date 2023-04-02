extends CharacterBody2D

@export var speed = 300.0
@export var turn_rate = 0.025
@export var shadow_offset = Vector2(-25, 50)

var rotation_dir = 0

func _physics_process(delta):
	rotation_dir = Input.get_axis("ui_left", "ui_right")
	rotation += rotation_dir * turn_rate
	velocity = transform.x * speed
	move_and_slide()
	$Shadow.global_position = global_position + shadow_offset
