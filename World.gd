extends Node2D

enum {
	RED,
	BLUE
}

onready var camera = $Camera2D
onready var player1 = $Player
onready var redhusk = $red_husk
onready var player2 = $player2

var state = RED

func _ready():
	pass

func _physics_process(delta):
	match state:
		RED:
			red()
		BLUE:
			blue()
			
	if Input.is_action_just_pressed("right_click") and state == RED:
		state = BLUE
	elif Input.is_action_just_pressed("right_click") and state == BLUE:
		state = RED


func red():
	player1.state = 1
	player2.state = 0
	camera.position = player1.position
	
func blue():
	player1.state = 0
	player2.state = 1
	camera.position = player2.position







