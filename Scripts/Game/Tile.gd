extends StaticBody3D

class_name Tile

@export var selectOffset: Vector3 = Vector3(0, 0.75, 0)

var health: float = 100.0

var maxHealth: float = 100.0

var directPollution: float = 0.0 # Pollution from a direct pollution source
var indirectPollution: float = 0.0 # Pollution from nearby polluted tiles

var gatheredPollution: float = 0.0 # Pollution gathered this tick

var tilesInArea: Array[Tile] = []

@export var healthyColor: Color = Color(0.0, 1.0, 0.0, 1.0)
@export var unhealthyColor: Color = Color(1.0, 0.0, 0.0, 1.0)

func UpdateArea(body: Node3D, enter: bool):
    if body is Tile:
        if enter:
            tilesInArea.append(body)
        else:
            tilesInArea.erase(body)

func SendPollution():
    for tile in tilesInArea:
        tile.gatheredPollution += ((directPollution / 1.5) + (indirectPollution / 4.0)) * (2 - position.distance_to(tile.position))
        

func ApplyIndirect():
    indirectPollution += gatheredPollution * 0.05

    indirectPollution *= 0.9
    if indirectPollution + directPollution > 100.0:
        indirectPollution = 100.0 - directPollution

    $DebugPollution.text = str(snapped(indirectPollution + directPollution, 0.01))
    gatheredPollution = 0.0

    health = clamp(maxHealth - indirectPollution - directPollution, 0.0, maxHealth)

    $Mesh.mesh.material.albedo_color = healthyColor.lerp(unhealthyColor, 1.0 - (health / maxHealth))