extends Node3D

class_name World
static var ins: World

@export var tileIns: PackedScene
var select: Node3D

var tilesInWorld: Array[Tile] = []

var pollutionTick: float = 0.0

func _init():
	ins = self

func _ready():
	select = $Select
	select.visible = false
	for i in range(15):
		for j in range(15):
			var tile = tileIns.instantiate()
			tile.position = Vector3(i, 0, j)
			add_child(tile)
			tilesInWorld.append(tile)
	Cam.ins.Focus(Vector3(7, 0, 7), false)

func _process(dt):
	var tile = SelectRay()
	if tile != null:
		if Input.is_action_just_pressed("Select"):
			Cam.ins.Focus(tile.position)
			tile.directPollution = 50.0
		select.position = tile.position + tile.selectOffset
		select.visible = true
	else:
		select.visible = false
	pollutionTick -= dt
	if pollutionTick < 0.0:
		UpdateTiles()
		pollutionTick += 0.5

func UpdateTiles():
	for tile in tilesInWorld:
		tile.SendPollution()
	for tile in tilesInWorld:
		tile.ApplyIndirect()

func SelectRay() -> Node3D:
	var camOrigin = Cam.ins.project_ray_origin(get_viewport().get_mouse_position())
	var camEnd = camOrigin + Cam.ins.project_position(get_viewport().get_mouse_position(), 1000)
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(camOrigin, camEnd)
	var result = space_state.intersect_ray(query)
	if result:
		if result["collider"].is_in_group("Tile"):
			return result["collider"]
	return null