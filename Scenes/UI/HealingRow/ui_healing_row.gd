extends HBoxContainer


@onready var small_num_potion = %lowNumPotion
@onready var med_num_potion = %medNumPotion
@onready var large_num_potion = %highNumPotion
@onready var variable_heal_button = %variableHealButton

@onready var restore_label = %RestoreLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	restoreMessages = ["","",""]
	SignalManager.buttonUseOption1.connect(use_small_potion)
	SignalManager.buttonUseOption2.connect(use_medium_potion)
	SignalManager.buttonUseOption3.connect(use_large_potion)
	SignalManager.buttonUseRandomHeal.connect(variableHeal)
	SignalManager.updatePotionLabels.connect(_update_button_text)
	_update_button_text()


#region VARIABLE AND POTION HEALING
func variableHeal() -> void:
	timeout_buttons("Vary")
	var randomHeal = randi_range(1, 10)
	UniversalVariables.heroHealthCurrent += randomHeal
	restore_label.text = str("Vary heal, +", randomHeal, " health")
	SignalManager.heroHealed.emit()
	if randomHeal >= 1 and randomHeal <= 3:
		SignalManager.lowHealSfxPlay.emit()
	elif randomHeal >= 4 and randomHeal <= 6:
		SignalManager.medHealSfxPlay.emit()
	elif randomHeal >= 7 and randomHeal <= 10:
		SignalManager.highHealSfxPlay.emit()
	update_restore_label(restore_label.text)


func potion_Heal(type: String, healAmount: int) -> void:
	timeout_buttons(type)
	restore_label.text = str(type, " potion, + ", healAmount, " health")
	_update_button_text()
	UniversalVariables.heroHealthCurrent += healAmount
	update_restore_label(restore_label.text)
#endregion


#region TIMEOUT BUTTONS
func timeout_buttons(type: String) -> void:
	if type.capitalize() == "Vary":
		variable_heal_button.disabled = true
		await get_tree().create_timer(0.80).timeout
		variable_heal_button.disabled = false
	else:
		small_num_potion. disabled = true
		med_num_potion. disabled = true
		large_num_potion.disabled = true
		await get_tree().create_timer(0.80).timeout
		small_num_potion. disabled = false
		med_num_potion. disabled = false
		large_num_potion.disabled = false
#endregion 


#region TEXT AND MESSAGE UPDATING 
#--- I did this because I couldnt figure out how to resize the array good
var restoreMessages: Array = ["","","",""]
func update_restore_label(sentence: String) -> void:
	restoreMessages.push_front(sentence)
	restoreMessages.resize(4)
	restore_label.text = str(restoreMessages[3], "\n" + restoreMessages[2], "\n" + restoreMessages[1], "\n" + restoreMessages[0] )
	SignalManager.heroHealed.emit() # "\n" + "Most Recent:", 


func _update_button_text() -> void:
	small_num_potion.text = str("Small Potion (+2) | ", UniversalVariables.smallPotionUseCount, "/5" )
	med_num_potion.text = str("Medium Potion (+5) | ", UniversalVariables.medPotionUseCount, "/5" )
	large_num_potion.text = str("Large Potion (+8) | ", UniversalVariables.largePotionUseCount, "/5" )
#endregion


#region USE POTION FUNCTIONS
func use_small_potion() -> void:
	var smallPotionCount = UniversalVariables.smallPotionUseCount
	_update_button_text()
	if smallPotionCount > 0:
		UniversalVariables.smallPotionUseCount -= 1
		potion_Heal("Small", 2)
		SignalManager.lowHealSfxPlay.emit()


func use_medium_potion() -> void:
	var medPotionCount = UniversalVariables.medPotionUseCount
	_update_button_text()
	if medPotionCount > 0:
		UniversalVariables.medPotionUseCount -= 1
		potion_Heal("Medium", 5)
		SignalManager.medHealSfxPlay.emit()


func use_large_potion() -> void:
	var largePotionCount = UniversalVariables.largePotionUseCount
	_update_button_text()
	if largePotionCount > 0:
		UniversalVariables.largePotionUseCount -= 1
		potion_Heal("Large", 8)
		SignalManager.highHealSfxPlay.emit()
#endregion
