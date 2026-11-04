extends StaticBody2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer

@export var dialogue_lines: Array[String] = ["Hello", "What's up?", "Ok bye"]
var dialogue_index: int = 0
@onready var dialogue_label: Label = $CanvasLayer/DialogueLabel
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var can_interact: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact:
		audio_stream_player_2d.play()
		if dialogue_index < dialogue_lines.size():
			canvas_layer.visible = true
			get_tree().paused = true
			dialogue_label.text = dialogue_lines[dialogue_index]
			dialogue_index += 1
		else:
			canvas_layer.visible = false
			get_tree().paused = false
			dialogue_index = 0
		
	pass
