extends Control


@export var generic_sprite_2d = PackedScene
@export var heroDict: Dictionary
var heroCounter: int = 0

#---Left Panel
@onready var game_subtitle = %"GameSubtitle"
@onready var game_credits = %"GameCredits"


#---Right Panel
@onready var hero_texture = %heroTexture
@onready var restock_label = %RestockLabel

@onready var menu_holder = %MenuHolder

@onready var tutorial_menu = %TutorialMenu
@onready var options_margins = %OptionsMargins
@onready var death_panel = %DeathPanel


#--- Right Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	set_default_vars()
	build_hero_array()
	hide_menu_holder_all()
	death_panel.hide()
	heroDict.size = 10
	
	
	game_subtitle.text = str(UniversalText.gameSubtitle)
	game_credits.text = str(UniversalText.gameCredits)
	tutorial_menu.text = str(UniversalText.gameTutorial)
	
	
	SignalManager.newHero.connect(spawn_new_hero)
	SignalManager.failstate.connect(game_end)
	SignalManager.buttonOptions.connect(open_options_menu)
	SignalManager.buttonTwo.connect(buttonTwo_press)
	SignalManager.buttonReset.connect(game_reset)
	
	shuffle_hero_array()


#region HERO ARRAY MANAGEMENT
var heroArray: Array
func build_hero_array() -> void:
	heroArray = [
		heroDict.TechMouse, heroDict.TreeHead, heroDict.TinyMan, heroDict.Skeleton, heroDict.Magma,
		heroDict.Lantern, heroDict.Ghost, heroDict.Dancer, heroDict.Jewel, heroDict.Warrior
		]


func shuffle_hero_array() -> void:
	heroArray.shuffle()
	hero_texture.texture = heroArray[heroCounter]
#endregion


#region GAME END AND RESET STATES
func game_end() -> void:
	death_panel.show()


func game_reset() -> void:
	get_tree().reload_current_scene()
	
	set_default_vars()
	
	SignalManager.updateHealthBar.emit()
#endregion


#region PRINT SINGLTONS
func print_singletons() -> void:
	print_debug("hero health current: ",  UniversalVariables.heroHealthCurrent )
	print_debug("hero health max: ",  UniversalVariables.heroHealthMax )
	print_debug("heroes healed: ",  UniversalVariables.heroesHealed)
	print_debug("player streak high score: ",  UniversalVariables.playerStreakHighScore )
	print_debug("player rounds until restock: ",  UniversalVariables.playerRoundsUntilRestock)
	print_debug("small pot use count: ",  UniversalVariables.smallPotionUseCount )
	print_debug("med pot use count: ",  UniversalVariables.medPotionUseCount )
	print_debug("large pot use count: ",  UniversalVariables.largePotionUseCount )
#endregion


#region SET DEFAULT VAR VALUES
func set_default_vars() -> void:
	UniversalVariables.heroHealthCurrent = 1
	UniversalVariables.heroesHealed = 0
	UniversalVariables.playerRoundsUntilRestock = 3
	UniversalVariables.playerRestockCounter = 0
	UniversalVariables.playerRestockRoundsScaling = 0
	UniversalVariables.smallPotionUseCount = 5
	UniversalVariables.medPotionUseCount = 5
	UniversalVariables.largePotionUseCount = 5
#endregion


#region SPAWN NEW HERO
func spawn_new_hero() -> void:
	print_debug("AAHAHHAHA", UniversalVariables.heroesHealed, UniversalVariables.playerStreakHighScore)
	heroCounter += 1
	UniversalVariables.heroesHealed += 1
	
	if UniversalVariables.heroesHealed >= UniversalVariables.playerStreakHighScore:
		UniversalVariables.playerStreakHighScore = UniversalVariables.heroesHealed
	
	restock_potions()
	
	if heroCounter >= 9: 
		heroCounter = 0
		shuffle_hero_array()
	hero_texture.texture = heroArray[heroCounter]
	
	SignalManager.updateTopRow.emit()
#endregion


#region RESTOCK POTIONS
func restock_potions() -> void:
	if UniversalVariables.playerRoundsUntilRestock > 0:
		UniversalVariables.playerRoundsUntilRestock -= 1
	
	await get_tree().create_timer(1.5).timeout
	
	if UniversalVariables.playerRoundsUntilRestock == 0:
		UniversalVariables.playerRoundsUntilRestock = 3
		var restockDelayCond1: bool = UniversalVariables.playerRestockCounter % 2 
		var restockDelayCond2: bool = UniversalVariables.playerRestockRoundsScaling < 10
		if (restockDelayCond1 == true) and (restockDelayCond2 == true):
			UniversalVariables.playerRestockRoundsScaling += 1
			UniversalVariables.playerRoundsUntilRestock =+ UniversalVariables.playerRestockRoundsScaling
		UniversalVariables.smallPotionUseCount += 3
		UniversalVariables.medPotionUseCount += 3
		UniversalVariables.largePotionUseCount += 3
		
		check_potion_count()
		
		SignalManager.updatePotionLabels.emit()
		restock_label.show()
		await get_tree().create_timer(1.0).timeout
		restock_label.hide()
#endregion


#region CHECK POTION COUNT
func check_potion_count() -> void:
	if UniversalVariables.smallPotionUseCount > 5:
		UniversalVariables.smallPotionUseCount = 5
		
	if UniversalVariables.medPotionUseCount > 5:
		UniversalVariables.medPotionUseCount = 5
		
	if UniversalVariables.largePotionUseCount > 5:
		UniversalVariables.largePotionUseCount = 5
#endregion


#region OPTIONS AND TUTORIAL MANAGER
func open_options_menu() -> void:
	toggle_menu_holder(options_margins, tutorial_menu)


func buttonTwo_press() -> void:
	toggle_menu_holder(tutorial_menu, options_margins)


func toggle_menu_holder(infoShow: Node, infoHide: Node) -> void:
	if menu_holder.is_visible_in_tree() == false:
		menu_holder.show()
		infoShow.show()
		infoHide.hide()
	elif menu_holder.is_visible_in_tree() == true:
		hide_menu_holder_all()

func hide_menu_holder_all() -> void:
	menu_holder.hide()
	tutorial_menu.hide()
	options_margins.hide()
#endregion
