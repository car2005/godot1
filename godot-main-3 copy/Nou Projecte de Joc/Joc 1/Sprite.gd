extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var velocitat = Vector2(200, 100)
var velocitat_angular = 90

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(100, 300)
# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocitat * delta
	$clon.rotation_degrees += velocitat_angular * delta
	
	if position.x >= 1024 or position.x <= 0:
		velocitat.x *= -1
	if position.y >= 600 or position.y <= 0:
		print(position.y)
		velocitat.y *= -1
		
