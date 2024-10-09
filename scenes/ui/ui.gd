extends CanvasLayer
class_name UI

@export var score_label: Label

var score: int = 0

func _ready():
	update_score_label()

func add_score(newScore: int):
	self.score += newScore
	update_score_label()

func update_score_label():
	score_label.text = str(score)
