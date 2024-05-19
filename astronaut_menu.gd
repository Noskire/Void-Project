extends RigidBody3D

const ACCELERATION = .8
const TURN_ACCEL = .8

var angle
func _physics_process(_delta):
	if Input.is_action_pressed("turn_left"):
		#apply_torque_impulse(Vector3(0, TURN_ACCEL, 0))
		angle = get_global_transform().basis.y
		apply_torque_impulse(angle * TURN_ACCEL)
	if Input.is_action_pressed("turn_right"):
		#apply_torque_impulse(Vector3(0, -TURN_ACCEL, 0))
		angle = get_global_transform().basis.y
		apply_torque_impulse(angle * -TURN_ACCEL)
	
	if Input.is_action_pressed("turn_ccw"):
		#apply_torque_impulse(Vector3(0, 0, TURN_ACCEL))
		angle = get_global_transform().basis.z
		apply_torque_impulse(angle * TURN_ACCEL)
	if Input.is_action_pressed("turn_cw"):
		#apply_torque_impulse(Vector3(0, 0, -TURN_ACCEL))
		angle = get_global_transform().basis.z
		apply_torque_impulse(angle * -TURN_ACCEL)
	
	if Input.is_action_just_pressed("stop_body"):
		sleeping = true
