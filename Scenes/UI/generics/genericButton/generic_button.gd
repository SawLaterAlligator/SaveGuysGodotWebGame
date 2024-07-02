extends Button

@export var buttonText: String = ""
@export var buttonSignal: String = ""
@export_category("Details:")
@export var buttonTextOff: bool = false
@export var Icon: Texture
@export_category("Toggle Settings")
@export var buttonToggle: bool = false
@export var offSignal: String = ""
@export var onSignal: String = ""
@export var offText: String = ""
@export var onText: String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if buttonToggle == true:
		self.toggle_mode = true
	
	self.icon = Icon

#region POSSIBLE SIGNALS
func call_signal() -> void:
	SignalManager.signal_dict[buttonSignal].emit()


func off_signal() -> void:
	SignalManager.signal_dict[offSignal].emit()


func on_signal() -> void:
	SignalManager.signal_dict[onSignal].emit()
#endregion

func _on_pressed():
	
	if buttonToggle == true:
		check_press_state()
	else:
		call_signal()


func check_press_state() -> void:
	if self.button_pressed == true:
		self.text = onText
		on_signal()
	elif self.button_pressed == false:
		self.text = offText
		off_signal()
