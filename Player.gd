extends RigidBody3D

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var menu = $"../Menu"
@onready var oxygen_bar = $"../Menu/HUD/OxygenBox/ProgressBar"
@onready var fuel_bar = $"../Menu/HUD/FuelBox/ProgressBar"
@onready var heart = $"../Heart"

@onready var jet_1 = $"../Jets/Jet1"
@onready var jet_2 = $"../Jets/Jet2"
@onready var jet_3 = $"../Jets/Jet3"
@onready var jet_4 = $"../Jets/Jet4"
@onready var jet_5 = $"../Jets/Jet5"
@onready var jet_6 = $"../Jets/Jet6"

const SENSITIVITY = 0.003
const ACCELERATION = 1
const TURN_ACCEL = 1

var angle
var time
var max_time = 90.0
var fuel
var max_fuel = 200
var fuel_consumption = 0.1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	time = 0.0
	fuel = max_fuel
	heart.pitch_scale = 0.9

func _physics_process(delta):
	if Input.is_action_just_pressed("hints"):
		menu.hints_menu()
	
	if Input.is_action_just_pressed("stop_body"):
		sleeping = true
	
	time += delta
	oxygen_bar.value = ((max_time - time) / max_time) * 100
	if time > max_time:
		var reason = "Your oxygen has run out!"
		menu.lose_menu(reason, float_to_time(time))
	elif time > max_time * 0.9:
		heart.pitch_scale = 1.6
	elif time > max_time * 0.8:
		heart.pitch_scale = 1.4
	elif time > max_time * 0.7:
		heart.pitch_scale = 1.2
	elif time > max_time * 0.6:
		heart.pitch_scale = 1.1
	elif time > max_time * 0.5:
		heart.pitch_scale = 1.0
	
	if fuel < 0: # Don't process input if has no fuel
		return
	
	if Input.is_action_pressed("forward"):
		angle = get_global_transform().basis.z
		apply_central_impulse(angle * -ACCELERATION)
		fuel -= fuel_consumption
		if not jet_1.is_playing():
			jet_1.play()
	if Input.is_action_pressed("backward"):
		angle = get_global_transform().basis.z
		apply_central_impulse(angle * ACCELERATION)
		fuel -= fuel_consumption
		if not jet_2.is_playing():
			jet_2.play()
	
	#if Input.is_action_pressed("up"):
		#angle = get_global_transform().basis.y
		#apply_central_impulse(angle * ACCELERATION)
		#fuel -= fuel_consumption
	#if Input.is_action_pressed("down"):
		#angle = get_global_transform().basis.y
		#apply_central_impulse(angle * -ACCELERATION)
		#fuel -= fuel_consumption
	
	if Input.is_action_pressed("turn_left"):
		#apply_torque_impulse(Vector3(0, TURN_ACCEL, 0))
		angle = get_global_transform().basis.y
		apply_torque_impulse(angle * TURN_ACCEL)
		fuel -= fuel_consumption
		if not jet_3.is_playing():
			jet_3.play()
	if Input.is_action_pressed("turn_right"):
		#apply_torque_impulse(Vector3(0, -TURN_ACCEL, 0))
		angle = get_global_transform().basis.y
		apply_torque_impulse(angle * -TURN_ACCEL)
		fuel -= fuel_consumption
		if not jet_4.is_playing():
			jet_4.play()
	
	if Input.is_action_pressed("turn_ccw"):
		#apply_torque_impulse(Vector3(0, 0, TURN_ACCEL))
		angle = get_global_transform().basis.z
		apply_torque_impulse(angle * TURN_ACCEL)
		fuel -= fuel_consumption
		if not jet_5.is_playing():
			jet_5.play()
	if Input.is_action_pressed("turn_cw"):
		#apply_torque_impulse(Vector3(0, 0, -TURN_ACCEL))
		angle = get_global_transform().basis.z
		apply_torque_impulse(angle * -TURN_ACCEL)
		fuel -= fuel_consumption
		if not jet_6.is_playing():
			jet_6.play()
	
	fuel_bar.value = (fuel / max_fuel) * 100
	#if fuel < 0:
		#var reason = "Your fuel has run out!"
		#menu.lose_menu(reason, float_to_time(time))

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		head.rotation.y = clamp(head.rotation.y, deg_to_rad(-40), deg_to_rad(40))

func _on_ship_area_entered(_body):
	menu.win_menu(float_to_time(time))

func float_to_time(f_time):
	var minute = int(f_time / 60)
	var sec = int(f_time - (minute * 60))
	if sec < 10:
		sec = '0' + str(sec)
	else:
		sec = str(sec)
	var txt_time = str(minute) + ':' + sec
	return txt_time
