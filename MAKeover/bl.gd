extends CharacterBody2D
var goal
var vell
var tower_from 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if ! is_instance_valid(get_node(goal)):
		get_tree().current_scene.get_node(tower_from).force_slain(goal)
		queue_free()
	elif goal:
		var goal = get_node(goal).global_position
		vell = position.direction_to(goal).normalized()

	velocity = vell  * 500
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.damage(80,tower_from)
		queue_free()
	pass # Replace with function body
