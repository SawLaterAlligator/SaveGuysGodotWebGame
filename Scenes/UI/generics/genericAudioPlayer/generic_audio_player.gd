extends AudioStreamPlayer

@export_category("General")
@export var audioType: String = ""
@export_category("Signal:")
@export var connectingSignal: String = ""
@export_category("Sound Effects")
@export var includedSfx: bool = false
@export var clickSfx: bool = false
@export var mouseClickSfx: bool = false
@export var rolloverSfx: bool = false
@export var switchSfx: bool = false
var soundArray: Array = []
var maxNum: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	#if audioType.capitalize() == "Music":
	#	SignalManager.optionsMusicChanged.connect(update_audio)
	#elif audioType.capitalize() == "Ui Sfx":
	#	SignalManager.optionsUi_SfxChanged.connect(update_audio)
	#elif audioType.capitalize() == "Heal Sfx":
	#	SignalManager.optionsHeal_SfxChanged.connect(update_audio)
	
	
	if not (connectingSignal == ""):
		SignalManager.signal_dict[connectingSignal].connect(play_audio)
	
	if includedSfx:
		if clickSfx == true:
			set_click_sfx()
		if mouseClickSfx == true:
			set_mouse_click_sfx()
		if rolloverSfx == true:
			set_rollover_sfx()
		if switchSfx == true:
			set_switch_sfx()
		
		maxNum = soundArray.size() - 1


func update_audio() -> void:
	self.volume_db = UniversalVariables.audioUiSfxVolume


func play_audio() -> void:
	if includedSfx == true: 
		var randNum = randi_range(0,maxNum)
		print_debug("sfx ", randNum, " / sfx ", maxNum)
		var sfxSelected = soundArray[randNum]
		var sfxLoaded = load(sfxSelected)
		self.set_stream(sfxLoaded)
	
	self.play()


#region SET CLICK SFX
func set_click_sfx() -> void:
	soundArray = ["res://Assets/Audio/Sound Effects/UI Noises/Audio/click1.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/click2.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/click3.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/click4.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/click5.ogg"]
#endregion


#region SET MOUSE CLICK SFX
func set_mouse_click_sfx() -> void:
	soundArray = ["res://Assets/Audio/Sound Effects/UI Noises/Audio/mouseclick1.ogg"]
#endregion


#region SET ROLLOVER SFX
func set_rollover_sfx() -> void:
	soundArray = ["res://Assets/Audio/Sound Effects/UI Noises/Audio/rollover1.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/rollover2.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/rollover3.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/rollover4.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/rollover5.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/rollover6.ogg"]
#endregion


#region SET SWITCH SFX
func set_switch_sfx() -> void:
	soundArray = ["res://Assets/Audio/Sound Effects/UI Noises/Audio/switch1.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch2.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch3.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch4.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch5.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch6.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch7.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch8.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch8.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch9.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch10.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch11.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch12.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch13.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch14.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch15.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch16.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch17.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch18.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch19.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch20.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch21.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch22.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch23.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch24.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch25.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch26.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch27.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch28.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch29.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch30.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch31.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch32.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch33.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch34.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch35.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch36.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch37.ogg",
	"res://Assets/Audio/Sound Effects/UI Noises/Audio/switch38.ogg"]
#endregion

