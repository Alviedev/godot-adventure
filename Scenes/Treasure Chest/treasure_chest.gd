extends StaticBody2D

@export var chest_name: String
var can_interact: bool = false
var is_open: bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.visible = false
	if SceneManager.opened_chests.has(chest_name):
		is_open = true
		animated_sprite_2d.play("open")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") and can_interact:
		if !is_open:
			open_chest()

func open_chest():
	audio_stream_player_2d.play()
	is_open = true
	animated_sprite_2d.play("open")
	sprite_2d.visible = true
	timer.start()
	SceneManager.opened_chests.append(chest_name)
	print(SceneManager.opened_chests)


func _on_timer_timeout() -> void:
	sprite_2d.visible = false
