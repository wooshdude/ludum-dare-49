extends Node2D

enum {
	RED,
	BLUE
}

onready var camera = $Camera2D
onready var player1 = $Player
onready var redhusk = $red_husk
onready var player2 = $player2
onready var rotater = $rotater
onready var point = $point
onready var platform = $platform

var state = RED

func _ready():
	pass

func _physics_process(delta):
	# PLACE CAMERA BETWEEN BOTH PLAYERS
	camera.global_position = (player2.global_position + player1.global_position) * .5
	
	# CHANGE WHICH PLAYER IS SELECTED
	match state:
		RED:
			red()
		BLUE:
			blue()
			
	# CAMERA
	var distance = sqrt(pow((player2.position.x - player1.position.x), 2) + pow((player2.position.y - player1.position.y), 2)) # get distance between players
	distance = distance * 0.0015
	if Input.is_action_pressed("right_click"):
		camera.global_position = (player2.global_position + player1.global_position) * .5 #place camera between players
		print(distance)
		camera.zoom = Vector2(distance, distance) #change zoom based on distance of players
		camera.offset_v = -0.10
	else:
		camera.zoom = Vector2(0.50, 0.50) # reset zoom
		camera.offset_v = -0.35
	
	
	# CAMERA ROTATE
	
	var playerCenter = (player1.global_position.x + player2.global_position.x) * 0.5 # get center of characters
	var rotateAmount = (playerCenter + platform.position.x) * 0.5 # get center of characters and x = 0
	point.global_position.x = rotateAmount # displays marker
	
	camera.rotation_degrees -= rotateAmount * 0.001 # rotates the camera based on distance to center
	#Physics2DServer.area_set_param(get_world_2d().space, Physics2DServer.AREA_PARAM_GRAVITY_VECTOR, Vector2.ZERO)


		
	print(rotateAmount * 0.00001)
	print(camera.rotation_degrees)
	
	if camera.rotation_degrees >= 32:
		print("bruhh")
	
	# switch controlls
	if Input.is_action_just_pressed("left_click") and state == RED:
		state = BLUE
	elif Input.is_action_just_pressed("left_click") and state == BLUE:
		state = RED


func red():
	player1.state = 1
	player2.state = 0
	
	
func blue():
	player1.state = 0
	player2.state = 1







