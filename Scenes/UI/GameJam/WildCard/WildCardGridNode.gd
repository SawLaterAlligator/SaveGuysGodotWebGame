extends Control

@onready var sprite_2d = $Sprite2D
@export var wildCardImage: Texture

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = wildCardImage
