extends Node2D

class_name Game

# Connect nodes
@export var ui: UI

#Add points upon destruction of entities
func _on_child_exiting_tree(node):
	if node is Asteroid:
		ui.add_score(150)

func _input(event):
	if Input.is_action_just_pressed("ui_exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("ui_reset"):
		get_tree().reload_current_scene()
