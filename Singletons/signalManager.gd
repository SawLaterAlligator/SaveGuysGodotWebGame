extends Node
#---HERO TRACKING
signal heroHealed
signal newHero
#---GAMESTATE
signal failstate
#---BUTTON TRACKING
signal buttonUseOption1
signal buttonUseOption2
signal buttonUseOption3
signal buttonUseRandomHeal
signal buttonTwo
signal buttonOptions
signal buttonReset
signal buttonSlider
#---UPDATE TRACKING
signal updateTopRow
signal updatePotionLabels
signal updateHealthBar
#---HEALING SFX
signal lowHealSfxPlay
signal medHealSfxPlay
signal highHealSfxPlay
#---Options 
signal optionsMusicSliderChanged
signal optionsAudioMuted
signal optionsAudioUnMuted

var signal_dict: Dictionary
#region SIGNAL DICTIONARY
func _ready():
	signal_dict["heroHealed"] = heroHealed
	signal_dict["newHero"] = newHero
	signal_dict["failstate"] = failstate
	signal_dict["buttonUseOption1"] = buttonUseOption1
	signal_dict["buttonUseOption2"] = buttonUseOption2
	signal_dict["buttonUseOption3"] = buttonUseOption3
	signal_dict["buttonUseRandomHeal"] = buttonUseRandomHeal
	signal_dict["buttonTwo"] = buttonTwo
	signal_dict["buttonOptions"] = buttonOptions
	signal_dict["buttonReset"] = buttonReset
	signal_dict["buttonSlider"] = buttonSlider
	signal_dict["updateTopRow"] = updateTopRow
	signal_dict["updatePotionLabels"] = updatePotionLabels
	signal_dict["updateHealthBar"] = updateHealthBar
	signal_dict["lowHealSfxPlay"] = lowHealSfxPlay
	signal_dict["medHealSfxPlay"] = medHealSfxPlay
	signal_dict["highHealSfxPlay"] = highHealSfxPlay
	signal_dict["optionsMusicSliderChanged"] = optionsMusicSliderChanged
	signal_dict["optionsAudioMuted"] = optionsAudioMuted
	signal_dict["optionsAudioUnMuted"] = optionsAudioUnMuted
#endregion
