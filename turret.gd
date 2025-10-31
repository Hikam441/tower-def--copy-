extends StaticBody2D
var roott = 0
var enemy 
var enemy_arr =[]
var enemy_dict = {}
@onready var path_bullet = preload("res://MAKeover/bl.tscn")
var inter = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ! enemy:
		if enemy_arr.size() > 0 :
			enemy = enemy_arr.front()
	elif ! is_instance_valid(get_node(enemy)):
		enemy = null
	elif not enemy == null :
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
	if body.is_in_group("enemy"):
		var path_enemy = get_path_to(body)
		enemy_arr.append(path_enemy)
		enemy_dict.get_or_add(body.id,path_enemy)
	pass # Replace with function body.
func enemy_exit(body: Node2D) -> void:
	if get_path_to(body) == enemy : 
		enemy_arr.erase(enemy)
		enemy = null 
		
	
	
	pass # Replace with function body.


func make_bullet():
	var bl = path_bullet.instantiate()
	bl.goal = enemy
	bl.tower_from = get_tree().current_scene.get_path_to(self)
	bl.position= position
	get_parent().add_child(bl)

func enemy_slain(path_id):
	if path_id in enemy_dict:
		enemy_arr.erase(enemy_dict[path_id])
		if enemy == enemy_dict[path_id]:
			enemy = null
		enemy_dict.erase(path_id)

func force_slain(obj):
	if obj in enemy_arr:
		if enemy_dict[enemy_arr.find(obj)]:
			enemy_dict[enemy_arr.find(obj)]
		enemy_arr.erase(obj)
		enemy = null
	
