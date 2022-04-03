extends Area2D

var coins = 0

func _on_coin_body_entered(body):
	if body.get_name() == "player":
		_on_coin1_coincollected().play()
		queue_free()
	
func _on_coin1_coincollected():
	$coinsound.play()
