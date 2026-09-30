extends CharacterBody2D
class_name Player

@export var move_speed = 100
@export var hp = 10
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position = SceneManager.player_spawn_position
	var score = 200
	
	print(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_vector * move_speed
	
	if velocity.x > 0:
		#print("player is moving right")
		animated_sprite_2d.play("move_right")
	elif velocity.x < 0:
		#print("player is moving left")
		animated_sprite_2d.play("move_left")
	elif velocity.y > 0:
		#print("player is moving down")
		animated_sprite_2d.play("move_down")
	elif velocity.y < 0:
		#print("player is moving up")
		animated_sprite_2d.play("move_up")
	else:
		#print ("player is not moving")
		animated_sprite_2d.stop()
	move_and_slide()
	#print(move_vector)
	
