extends HBoxContainer

@onready var typeLabel = $TypeLabel
@onready var margin_container = $MarginContainer
@onready var progressBar = $MarginContainer/ProgressBar
@onready var maxLabel = $MaxLabel

func _ready():
	SignalManager.heroHealed.connect(on_any_healing)
	SignalManager.updateHealthBar.connect(update_text)
	
	maxLabel.text = str("/ ", UniversalVariables.heroHealthMax)
	typeLabel.text = str("Current Health: 1")
	progressBar.value = UniversalVariables.heroHealthCurrent


func update_text() -> void:
	maxLabel.text = str("/ ", UniversalVariables.heroHealthMax)
	typeLabel.text = str("Current Health: ", UniversalVariables.heroHealthCurrent)
	progressBar.value = UniversalVariables.heroHealthCurrent

#region ON ANY HEALING FUNC
func on_any_healing() -> void:
	typeLabel.text = str("Current Health: ", UniversalVariables.heroHealthCurrent)
	if UniversalVariables.heroHealthCurrent < 21:
		
		while progressBar.value < UniversalVariables.heroHealthCurrent:
			progressBar.value += 0.2
			await get_tree().create_timer(0.01).timeout
		
		progressBar.value = UniversalVariables.heroHealthCurrent
		
	elif UniversalVariables.heroHealthCurrent == UniversalVariables.heroHealthMax:
		progressBar.value = UniversalVariables.heroHealthCurrent
		SignalManager.newHero.emit()
		generate_starting_health()
	else:
		progressBar.value = 0
		SignalManager.failstate.emit()
#endregion 

func generate_starting_health() -> void:
	UniversalVariables.heroHealthCurrent = randi_range(1, 7)
	update_text()
