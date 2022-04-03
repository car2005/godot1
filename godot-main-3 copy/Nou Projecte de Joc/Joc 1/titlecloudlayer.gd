extends TextureRect

var offset_x = 0

func _physics_process(_delta):
	set_motion_offset(Vector2(offset_x,0))
	offset_x += -1
	pass
