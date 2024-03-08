extends Node2D

var troop_scene = preload ("res://Scenes/Rendering/rendered_troop.tscn")
var card: Card

const TILE_SIZE = 64
@onready var game: Game = $Game

# Called when the node enters the scene tree for the first time.
func _ready():
	# Renders the background
	var board: Board = game.board
	var background: Sprite2D = $Background
	background.region_rect.size = TILE_SIZE * Vector2(board.SIZE.x, board.SIZE.y)
	# Renders the tiles
	var terrain: TileMap = $TerrainRenderer
	terrain.board = board
	terrain.render_all()
	# Renders fog
	var fog: TileMap = $FogRenderer
	fog.setup(board)
	# Sets up hand rendering
	var hand_renderer = $GUI_Renderer/HandRenderer
	hand_renderer.setup(board.players[board.current_player])
	
	# var instance5 = hand_scene.instantiate()
	# instance5.position = Vector2(814, 233)
	# instance5.scale.x = 0.15
	# instance5.scale.y = 0.2
	# %UI.add_child(instance5)

## Renders a troop card by adding it to the scene tree
func render_troop(troop: Troop, pos: Vector2i):
	var instance = troop_scene.instantiate()
	instance.prepare_for_render(troop)
	instance.position = Vector2(pos) * TILE_SIZE
	add_child.call_deferred(instance)
