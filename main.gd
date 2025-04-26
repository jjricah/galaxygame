extends Node2D

@onready var moon: AnimatedSprite2D = $moon

# State for the moon character
var moon_state = {
	"is_facing_right": true,
	"velocity": Vector2.ZERO
}

var move_speed = 100  # Movement speed

func _ready():
	pass

func _process(delta):
	control_character(moon, delta, moon_state)

func control_character(sprite: AnimatedSprite2D, delta: float, state: Dictionary):
	# Reset velocity
	state["velocity"] = Vector2.ZERO

	var is_moving = false

	# Horizontal input
	if Input.is_action_pressed("move_left"):
		state["velocity"].x = -move_speed
		state["is_facing_right"] = false
		is_moving = true
		sprite.play("walk-left")
	elif Input.is_action_pressed("move_right"):
		state["velocity"].x = move_speed
		state["is_facing_right"] = true
		is_moving = true
		sprite.play("walk-right")

	# Vertical input
	if Input.is_action_pressed("move_up"):
		state["velocity"].y = -move_speed
		is_moving = true
		sprite.play("walk-up")
	elif Input.is_action_pressed("move_down"):
		state["velocity"].y = move_speed
		is_moving = true
		sprite.play("walk-down")

	# Idle check
	if not is_moving:
		var stand_dir = "" if state["is_facing_right"] else "-left"
		sprite.play("idle" + stand_dir)

	# Apply movement
	sprite.position += state["velocity"] * delta
