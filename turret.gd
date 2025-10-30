extends StaticBody2D
var roott = 0
var enemy 

@onready var path_bullet = preload("res://MAKeover/bl.tscn")
var inter = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not enemy == null :
		var pos_enmy= get_node(enemy).global_position
		var anglee =position.angle_to_point(pos_enmy)
		rotation = rotate_toward(rotation,anglee,delta * 12)
		pass
		if inter >= 0 :
			inter -= delta
		elif inter <0 :
			inter = 0.5
			make_bullet()
	pass


func enemy_entered(body: Node2D) -> void:
	if not enemy == null :
		pass
	elif body.is_in_group("enemy"):
		enemy = get_path_to(body)
	pass # Replace with function body.
func enemy_exit(body: Node2D) -> void:
	if get_path_to(body) == enemy : enemy = null 
	
	
	pass # Replace with function body.


func make_bullet():
	var bl = path_bullet.instantiate()
	bl.goal = enemy
	bl.position= position
	get_parent().add_child(bl)
