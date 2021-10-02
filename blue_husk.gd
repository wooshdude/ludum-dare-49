extends KinematicBody2D

enum {
	IDLE,
	MOVE,
	SLAM,
	INTERACT
}

onready var timer = $Timer

export (int) var speed = 150
export (int) var jump_speed = -300
export (int) var gravity = 600
export (float) var friction = 0.2
export (float) var acceleration = 0.25


var velocity = Vector2.ZERO
var state = IDLE


func _physics_process(delta):
	match state:
		IDLE:
			idle(delta)
		MOVE:
			move(delta)
		SLAM:
			slam(delta)
		INTERACT:
			pass

# MOVEMENT

func move(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = jump_speed

func get_input():
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
	if Input.is_action_pressed("ui_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		
#	if Input.is_action_pressed("ui_down"):
#		state = SLAM

func idle(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0, friction)

# SLAM

func slam(delta):
	timer.start()

func _on_Timer_timeout(delta):
	velocity.y += gravity * delta * 8
	velocity = move_and_slide(velocity, Vector2.UP)
	state = MOVE
