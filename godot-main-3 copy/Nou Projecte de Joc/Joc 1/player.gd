extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0, 0)
export var max_velocity = 100
export (String, FILE) var nextlevel 
var gravity = Vector2(0, 9.8)
var jump_speed = -600
const floor_normal = Vector2(0, -1)
var coins = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	position = Vector2()

func _process(delta):
	position += velocity * delta
	
func collision(delta):
	move_and_slide(velocity * delta, floor_normal)
	
func _physics_process(_delta):
	move()
	collision(_delta)
	motion(_delta)

func move():
	if Input.is_action_pressed("ui_left"):
		velocity.x += -max_velocity 
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	if Input.is_action_just_released("ui_left"):
		velocity *= 0
		$AnimatedSprite.play("stand")
	if Input.is_action_pressed("ui_right"):
		velocity.x += max_velocity
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	if Input.is_action_just_released("ui_right"):
		velocity *= 0
		$AnimatedSprite.play("stand")
	if Input.is_action_pressed("ui_down"):
		velocity *= 0
		$AnimatedSprite.play("duck")
	if Input.is_action_just_released("ui_down"):
		$AnimatedSprite.play("stand")
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y += -max_velocity
		$AnimatedSprite.play("climb")
	if Input.is_action_just_released("ui_up"):
		velocity *= 0
		$AnimatedSprite.play("stand")
	if Input.is_action_just_pressed("ui_home") and is_on_floor():
		velocity.y += jump_speed
		$AnimatedSprite.play("jump")
	if Input.is_action_just_released("ui_home"):
		velocity *= 0
		$AnimatedSprite.play("stand")
		
	if !is_on_floor():
		velocity += gravity
		
func motion(_delta):
	if collision(_delta):
		velocity = velocity.slide(collision(_delta).normal)
	
func _on_fallzone_body_entered(body):
	if body.get_name() == "player":
		coins = 0
		get_tree().change_scene_to(load("res://Node2D.tscn"))

func _on_coin1_coincollected():
	pass
	
func _on_goal_body_entered(body):
	if body.get_name() == "player":
		get_tree().change_scene_to(load(nextlevel))

func _on_wormbody_body_entered(body):
	if body.get_name() == "player":
		get_tree().change_scene_to(load("res://Node2D.tscn"))

func _on_worm_player_killed():
	get_tree().change_scene("res://Node2D.tscn")

func _on_saw_player_killed():
	get_tree().change_scene("res://Node2D.tscn") # Replace with function body.
