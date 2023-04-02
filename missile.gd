extends Area2D

# Slightly faster than the player
@export var speed = 310
# How fast can the missile turn?
@export var steer_force = 600.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null

func start(_transform, _target):
	global_transform = _transform
	velocity = transform.x * speed
	target = _target
	
func seek():
	var steer = Vector2.ZERO
	if target:
		# Desired velocity is full speed toward the target
		var desired = position.direction_to(target.position) * speed
		# Steer is the vector from current to desired velocity, scaled by the steering force
		steer = velocity.direction_to(desired) * steer_force
	return steer
	
func _physics_process(delta):
	acceleration = seek()
	velocity += acceleration * delta
	velocity = velocity.limit_length(speed)
	rotation = velocity.angle()
	position += velocity * delta

func explode():
	set_physics_process(false)
	velocity = Vector2.ZERO
	$AnimationPlayer.play("explosion")
	await $AnimationPlayer.animation_finished
	queue_free()

func _on_body_entered(body):
	explode()
