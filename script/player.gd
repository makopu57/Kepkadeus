extends CharacterBody2D

@export var speed: int = 100
@export var jump: int = -1000
@export var gravity: float  = ProjectSettings.get_setting("physics/2d/default_gravity")

const SPEED: float = 300.0
const JUMP_POWER: float = -1000.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump #JUMP_POWER
	
	var direction: float = Input.get_axis("move_a","move_d")
	velocity.x = direction * speed #SPEED
	
	move_and_slide()
