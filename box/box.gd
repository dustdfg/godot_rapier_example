extends CharacterBody2D
class_name Box

var gravity = 1000
var speed = 500
var jump_velocity = 500

var _player_controlled : bool = false
@export var player_controlled : bool = false :
	set(value):
		if value == false:
			modulate = Color8(255, 255, 255)
		else:
			modulate = Color8(255, 0, 0)
		_player_controlled = value
	get:
		return _player_controlled



func _physics_process(delta):
	
	if player_controlled:
		if Input.is_action_just_pressed("player_jump"):
			velocity.y -= jump_velocity
		var direction := Input.get_axis("player_left", "player_right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	apply_floor_snap()
	move_and_slide()
	#var collision = move_and_collide(velocity)
	#if collision:
		#var collider = collision.get_collider()
		#print(name, " : ",
				#collider.name, " : ",
				#collision.get_normal(), " : ",
				#collision.get_position(), " : ",
				#collision.get_depth(), " : ",
				#collision.get_angle(), " : ",
				#collision.get_remainder(), " : ",
				#collision.get_travel(), " : ",)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if get_child(0).get_rect().has_point(to_local(event.position)):
			player_controlled = !player_controlled
