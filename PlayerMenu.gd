extends CanvasLayer

@onready var win = $Win
@onready var win_time = $Win/VBox/Time

@onready var lose = $Lose
@onready var lose_reason = $Lose/VBox/Reason
@onready var lose_time = $Lose/VBox/Time

@onready var hints = $Hints

var menu_scene = preload("res://menu.tscn").instantiate()

func win_menu(time):
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	win.visible = true
	win_time.set_text("Time: " + time)

func lose_menu(reason, time):
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	lose.visible = true
	lose_reason.set_text(reason)
	lose_time.set_text("Time: " + time)

func _on_restart_button_up():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_menu_button_up():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")

func hints_menu():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	hints.visible = true

func _on_back_button_up():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hints.visible = false
