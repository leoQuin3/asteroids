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
@export var idle_timer: Timer
@export var debris_particle: PackedScene

# Delegate function based on current state
var state_function = func() : chase()

# Get player upon entering scene, and begin timer
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	state_timer.start()
	
# Update every frame
func _process(delta):
	state_function.call()
	move_and_slide()

# Follow Player
func chase() -> void:
	if (player == null):
		set_state(STATES.IDLE)
		return
	
	var last_Position = self.global_position
	var new_Direction = (player.global_position - last_Position).normalized()
	self.velocity = new_Direction * SPEED

#Shoot at Player
func attack() -> void:
	if !player:
		randomize_velocity()
		set_state(STATES.IDLE)
		return
	self.velocity = Vector2.ZERO
	weapon_holder.look_at(player.global_position)
	weapon.fire()

func idle() -> void:
	if (idle_timer.is_stopped()):
		idle_timer.start()

# Delete self
func destroy() -> void:
	if debris_particle.can_instantiate():
		var debris: CPUParticles2D = debris_particle.instantiate()
		debris.position = self.global_position
		debris.emitting = true
		get_tree().root.add_child(debris)
	queue_free()

func set_state(new_state: STATES) -> void:
	current_state = new_state
	match new_state:
		STATES.IDLE:
			state_function = func() : idle()
		STATES.CHASE:
			state_function = func() : chase()
		STATES.ATTACK:
			state_function = func() : attack()
	state_timer.start()

# Set next state after the other
func _on_state_timer_timeout():
	match current_state:
		STATES.IDLE:
			set_state(STATES.CHASE)
		STATES.CHASE:
			set_state(STATES.ATTACK)
		STATES.ATTACK:
			set_state(STATES.CHASE)

func randomize_velocity():
	var randomDirection: = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	self.velocity = randomDirection * SPEED

func _on_idle_timer_timeout():
	randomize_velocity()

func _on_saucer_detection_area_body_entered(body):
	if body is Player and body.has_method("destroy"):
		body.destroy()
