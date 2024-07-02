extends HBoxContainer


@onready var restock_label = %RestockLabel
@onready var high_score_label = %HighScoreLabel
@onready var streak_label = %StreakLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.updateTopRow.connect(update_text)
	on_reset()


func on_reset() -> void:
	UniversalVariables.playerRoundsUntilRestock = 3
	restock_label.text = str( UniversalVariables.playerRoundsUntilRestock, """ Rounds
	Until Restock""")
	if UniversalVariables.heroesHealed < 1:
		high_score_label.text = str("Healed heroes in", "\n" +
		"furthest run: ", UniversalVariables.playerStreakHighScore )
	streak_label.text = str("Adventurers", "\n" +
	"healed: ", UniversalVariables.heroesHealed)


func update_text() -> void:
	
	restock_label.text = str( UniversalVariables.playerRoundsUntilRestock, """ Rounds
	Until Restock""")
	
	high_score_label.text = str("Healed heroes in", "\n" + 
	"furthest run: ", UniversalVariables.playerStreakHighScore )
	
	streak_label.text = str("Adventurers", "\n" +
	"healed: ", UniversalVariables.heroesHealed)


