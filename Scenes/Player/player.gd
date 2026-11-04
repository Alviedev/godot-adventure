extends CharacterBody2D
class_name Player

@export var move_speed = 100
@export var hp = 10
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var push_strength := 500
@onready var interact_box: Area2D = $InteractBox
@onready var treasure_label: Label = %TreasureLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SceneManager.player_spawn_position != Vector2(0,0):
		self.position = SceneManager.player_spawn_position
	var score = 200
	interact_box.position = Vector2(0,8)
	update_treasure_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_player()
	push_blocks()
	move_and_slide()
	update_treasure_label()

func move_player():
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_vector * move_speed
	
	if velocity.x > 0:
		#print("player is moving right")
		animated_sprite_2d.play("move_right")
		interact_box.position = Vector2(5,2)
	elif velocity.x < 0:
		#print("player is moving left")
		animated_sprite_2d.play("move_left")
		interact_box.position = Vector2(-5,2)
	elif velocity.y > 0:
		#print("player is moving down")
		animated_sprite_2d.play("move_down")
		interact_box.position = Vector2(0,8)
	elif velocity.y < 0:
		#print("player is moving up")
		animated_sprite_2d.play("move_up")
		interact_box.position = Vector2(0,-8)
	else:
		#print ("player is not moving")
		animated_sprite_2d.stop()

func push_blocks(): 
	# Get the last collision
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision:
		var collider_node = collision.get_collider()
		# Check for block
		if collider_node.is_in_group("pushable"):
			# If it is the block, push
			var collision_normal: Vector2 = collision.get_normal()
			collider_node.apply_central_force(-collision_normal * push_strength)


func _on_interact_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.scale += Vector2(0.1,0.1)
		body.can_interact = true


func _on_interact_box_body_exited(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.scale -= Vector2(0.1,0.1)
		body.can_interact = false

func update_treasure_label():
	var treasure_amount: int = SceneManager.opened_chests.size()
	treasure_label.text = str(treasure_amount)
