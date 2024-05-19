extends Node3D

@onready var player = $Player

var rng = RandomNumberGenerator.new()
var impulse
var angle
var imp_range = 50

func _process(_delta):
	impulse = rng.randf_range(-imp_range, imp_range)
	angle = player.get_global_transform().basis.z
	player.apply_central_impulse(angle * impulse)
	
	impulse = rng.randf_range(-imp_range, imp_range)
	angle = player.get_global_transform().basis.y
	player.apply_torque_impulse(angle * impulse)
	
	impulse = rng.randf_range(-imp_range, imp_range)
	angle = player.get_global_transform().basis.z
	player.apply_torque_impulse(angle * impulse)
	
	set_process(false)
