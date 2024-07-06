extends Node2D

class_name Game

@export var ui: UI

#Add points upon destruction of entities
func _on_child_exiting_tree(node):
	if node is Asteroid:
		ui.add_score(150)
