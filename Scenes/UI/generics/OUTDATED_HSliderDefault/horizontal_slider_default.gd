extends HBoxContainer

@onready var label = $Label
@onready var margin_container = $MarginContainer
@onready var h_slider = $MarginContainer/HSlider
@onready var button = $Button
@onready var sliderValue = h_slider.value

@export_category("General")
@export var labelText: String = "filler"

@export var sliderMargins: int = 15
@export var sliderPurpose: String = ""
@export_category("Slider Steps")
@export var sliderMin: int = 0
@export var sliderMax: int = 0
@export var sliderStep: float = 0
@export_category("Slider Ticks")
@export var sliderTickCount: int = 0
@export var sliderTickBorders: bool = true
@export_category("Reset Button")
@export var buttonText: String = "filler"
@export var buttonIcon: Texture


var sliderDefaultValue


# Called when the node enters the scene tree for the first time.
func _ready():
	#if sliderPurpose.capitalize() == "Music":
	#	sliderDefaultValue = UniversalVariables.audioMusicVolume
	#elif sliderPurpose.capitalize() == "Ui Sfx":
	#	sliderDefaultValue = UniversalVariables.audioUiSfxVolume
	#elif sliderPurpose.capitalize() == "Heal Sfx":
	#	sliderDefaultValue = UniversalVariables.audioHealSfxVolume
	
	_set_label_values()
	_set_slider_values()
	_set_button_values()

#region SLIDER PREP.
func _set_label_values() -> void:
	label.text = labelText


func _set_slider_values() -> void:
	margin_container.add_theme_constant_override("margin_left", sliderMargins)
	margin_container.add_theme_constant_override("margin_right", sliderMargins)
	h_slider.value = sliderDefaultValue
	h_slider.min_value = sliderMin
	h_slider.max_value = sliderMax
	h_slider.step = sliderStep
	h_slider.tick_count = sliderTickCount
	h_slider.ticks_on_borders = sliderTickCount


func _set_button_values() -> void:
	button.text = buttonText
	button.icon = buttonIcon
#endregion


#region RESET BUTTON
func _on_button_pressed():
	print_debug(h_slider.value)
	h_slider.value = sliderDefaultValue
	#UniversalVariables._set_global_gravity(h_slider.value)
	print_debug(h_slider.value)
#endregion


func _on_h_slider_drag_ended(value_changed):
	SignalManager.buttonSlider.emit()
	if value_changed == true:
		_update_value()


func _on_h_slider_drag_started():
	SignalManager.buttonSlider.emit()
	_update_value()


func _update_value() -> void:
	sliderDefaultValue = h_slider.value
