extends CharacterBody2D

@export var speed: float = 300.0
@export var movement_target: Marker2D

@onready var nav_agent: NavigationAgent2D =$NavigationAgent2D

func _ready() -> void:
	# Sinkronisasi dengan NavigationServer
	await get_tree().physics_frame
	set_target_position($"../Sprite2D3".global_position)
	# Atur tujuan awal
	if movement_target:
		nav_agent.target_position = movement_target.global_position

func _physics_process(delta: float) -> void:
	if not nav_agent.is_navigation_finished():
		if velocity.x < 0: $AnimatedSprite2D.scale.x= -5
		elif velocity.x >= 0: $AnimatedSprite2D.scale.x= 5
		var next_point: Vector2 = nav_agent.get_next_path_position()
		var direction: Vector2 = global_position.direction_to(next_point)
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO # Berhenti ketika tujuan tercapai

func set_target_position(new_target_pos: Vector2) -> void:
	nav_agent.target_position = new_target_pos
	
func damage(in_damage:int):
	pass
