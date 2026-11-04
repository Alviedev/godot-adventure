extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var is_single_use: bool = false
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

signal pressed 
signal unpressed

var bodies_on_top := 0

func _on_body_entered(body: Node2D) -> void:
	bodies_on_top += 1
	if body.is_in_group("pushable") or body is Player:
		audio_stream_player_2d.pitch_scale = 1.0
		audio_stream_player_2d.play()
		if bodies_on_top == 1:
			animated_sprite_2d.play("pressed")
			pressed.emit()


func _on_body_exited(body: Node2D) -> void:
	if is_single_use:
		return
	
	bodies_on_top -= 1
	if body.is_in_group("pushable") or body is Player:
		audio_stream_player_2d.pitch_scale = 0.8
		audio_stream_player_2d.play()
		if bodies_on_top == 0:
			animated_sprite_2d.play("unpressed")
			unpressed.emit()
