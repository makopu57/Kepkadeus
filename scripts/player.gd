extends CharacterBody2D

@export var speed: int = 250
@export var jump: int = -620
@export var gravity: float  = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var animated_sprite: AnimatedSprite2D
enum State {
	IDLE,
	RUN,
	JUMP,
	FALL
}
var current_state: State = State.IDLE

func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("move_a","move_d")
	
	apply_gravity(delta)
	apply_jump()
	apply_movment(direction)
	handle_flip(direction)
	move_and_slide()
	play_animation()
	update_state(direction)
	
func apply_gravity(delta: float) ->void:
	if not is_on_floor():
		velocity.y += gravity * delta

func apply_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump 

func apply_movment(direction: float) -> void:
	velocity.x = direction * speed

func handle_flip(direction) -> void:
	if direction > 0.0:
		animated_sprite.flip_h = false
	elif direction < 0.0:
		animated_sprite.flip_h = true

func update_state(direction: float) -> void:
	if is_on_floor():
		if direction == 0.0:
			current_state = State.IDLE
		else:
			current_state = State.RUN
	else:
		if velocity.y >= 0.0:
			current_state = State.JUMP
		else:
			current_state = State.FALL

func play_animation() -> void:
	match current_state:
		State.IDLE:
			animated_sprite.play("IDLE")
		State.RUN:
			animated_sprite.play("RUN")
		State.JUMP:
			animated_sprite.play("JUMP")
		State.FALL:
			animated_sprite.play("FALL")
