extends CharacterBody2D

var ghost_scene: PackedScene = preload("res://Scenes/ghost.tscn")
var speed: int = 200
var dash_speed: int = 500
var is_dashing: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	
	if Input.is_action_just_pressed("dash"):
		is_dashing = true
		$dash_timer.start()
		$ghost_timer.start()
		add_ghost()
		
	if  is_dashing == true:
		velocity = Vector2(1,0) * dash_speed
	else:
		velocity = direction * speed
	
	move_and_slide()


func _on_dash_timer_timeout():
	is_dashing = false

func add_ghost():
	var ghost = ghost_scene.instantiate() 
	ghost.set_property(position, $Sprite2D.scale)
	get_tree().current_scene.add_child(ghost)

func _on_ghost_timer_timeout():
	add_ghost()
