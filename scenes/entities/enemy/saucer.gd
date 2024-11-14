extends CharacterBody2D
class_name Saucer

# States
enum STATES {IDLE, ATTACK, CHASE}
var current_state: STATES = STATES.CHASE

# Properties
const SPEED: float = 100.0
var player: Player

# Connect nodes
@export var weapon: Weapon
@export var weapon_holder: Node2D
@export var state_timer: Timer

# Delegate function based on current state
var state_function = func() : chase()

# Get player upon entering scene
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	state_timer.start()
	
# Update every frame
func _process(delta):
	match current_state:
		STATES.IDLE:
			state_function = func() : idle()
		STATES.CHASE:
			state_function = func() : chase()
		STATES.ATTACK:
			state_function = func() : attack()
	state_function.call()
	move_and_slide()

# Follow Player
func chase() -> void:
	var last_Position = self.global_position
	var new_Direction = (player.global_position - last_Position).normalized()
	self.velocity = new_Direction * SPEED

#Shoot at Player
func attack() -> void:
	if !player:
		return
	self.velocity = Vector2.ZERO
	weapon_holder.look_at(player.global_position)
	weapon.fire()

func idle() -> void:
	pass

# Delete self
func destroy() -> void:
	queue_free()

func set_state(new_state: STATES) -> void:
	print("State set to " + str(new_state))
	current_state = new_state

func _on_state_timer_timeout() -> void:
	match current_state:
		STATES.IDLE:
			set_state(STATES.CHASE)
		STATES.CHASE:
			set_state(STATES.ATTACK)
		STATES.ATTACK:
			set_state(STATES.CHASE)
	state_timer.start()
