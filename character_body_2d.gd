extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		spawnObj(self.position)
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
func spawnObj(pos):
	var obj = preload("res://jumppad.tscn")

	var instance = obj.instantiate()
	var targetNode = get_parent()
	targetNode.add_child(instance)

	instance.position = pos
	print("works")

	
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	velocity.y = JUMP_VELOCITY
	if area.is_in_group("jump"):
		velocity.y = JUMP_VELOCITY
		print(area)
