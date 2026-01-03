class_name Player extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var max_jumps: int = 3
var jumps: int = max_jumps
@onready var bar = $Jumps

func _ready() -> void:
	EventController.connect("powerup", on_powerup)
	global_position.x = 100
	global_position.y = -100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps = max_jumps
		bar.update_jumps()

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jumps > 0:
		velocity.y = JUMP_VELOCITY
		jumps -= 1
		bar.update_jumps()
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if global_position.y > 120:
		global_position.x = 100
		global_position.y = -100

	move_and_slide()

func on_powerup():
	print("powerup")
	max_jumps += 1
	jumps = max_jumps
