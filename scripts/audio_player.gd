extends Node

var hurt = preload("res://assets/audio/hurt.wav")
var jump = preload("res://assets/audio/jump.wav")


func play_sfx(sfx_name: String) -> void:

	var stream = null

	if sfx_name == "hurt":
		stream = hurt
	elif sfx_name == "jump":
		stream = jump
	else:
		return

	var asp = AudioStreamPlayer.new()
	asp.name = "SFX"
	asp.stream = stream
	
	add_child(asp)
	asp.play()
	
	await asp.finished
	asp.queue_free()
