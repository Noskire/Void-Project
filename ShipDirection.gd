extends Node3D

@onready var player = $"../Player"
@onready var space_ship = $"../SpaceShip"

func _process(_delta):
	position = player.position
	look_at(-space_ship.position)
