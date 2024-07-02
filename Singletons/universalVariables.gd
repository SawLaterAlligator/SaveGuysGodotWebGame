extends Node

var heroHealthCurrent: int = 1
const heroHealthMax: int = 21
var heroesHealed: int = 0

#---set to 0 upon launch
var playerStreakHighScore: int = 0
var playerRoundsUntilRestock: int = 3
var playerRestockRoundsScaling: int = 0
var playerRestockCounter: int = 0

#---Cannot exceed 5, can not go below 0
var smallPotionUseCount: int = 5 
var medPotionUseCount: int = 5 
var largePotionUseCount: int = 5

#---THREE FUNCTIONS FOR EACH OPTION THAT GENERATE A NUMBER
#--WHICH IS THEN MANUALLY ADDED TO THE PLAYER HEALTH

#---Options
var audioMuted: bool = false
var audioUiSfxVolume: int = 0
var audioHealSfxVolume: int = 0
var audioMusicVolume: int = 0

#UniversalVariables.audioMuted
#UniversalVariables.audioUiSfxVolume
#UniversalVariables.audioHealSfxVolume
#UniversalVariables.audioMusicVolume
