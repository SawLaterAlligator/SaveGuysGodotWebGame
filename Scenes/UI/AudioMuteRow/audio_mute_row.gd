extends Panel

@onready var mute_toggle = %muteToggle

# Called when the node enters the scene tree for the first time.
func _ready():
	mute_toggle.text = "Off"
	
	SignalManager.optionsAudioMuted.connect(mute_audio)
	SignalManager.optionsAudioUnMuted.connect(unmute_audio)


func mute_audio() -> void:
	AudioServer.set_bus_mute(0, true)


func unmute_audio() -> void:
	AudioServer.set_bus_mute(0, false)
