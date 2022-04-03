extends CanvasLayer

var time = 90

func _ready():
	$Panel/countdowntime.text = String(time)
	$Timer.start(1)
	
func _on_Timer_timeout():
		time = time - 1
		$Panel/countdowntime.text = String(time)
		if time == 0:
			get_tree().change_scene("res://theend.tscn")
