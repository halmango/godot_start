extends Node2D

@onready var player: CharacterBody2D = $player
@onready var laser_spawner: Node = $laserSpawner
@onready var enem_spawner: Node = $enemySpawner
@onready var stage_label: Label = $stageLabel
@onready var kill_label: Label = $killLabel


const ENEMY = preload("res://Scenes/enemy.tscn")

@export var kill_count : int = 0
@export var level : int = 1
@export var stage : int = 1


func _ready() -> void:
	player.shot_laser.connect(on_shot_laser)
	start_game()


func start_game() -> void:
	var loaded_data : GameData = ResourceLoader.load("res://Resources/save_data.tres")
	kill_count = loaded_data.kill_count
	level = loaded_data.level
	stage = loaded_data.stage
	stage_label.text = "Stage: " + str(stage)
	kill_label.text = "Kills: " + str(kill_count)
	spawn_enemy(stage)


func on_shot_laser(laser_scn : PackedScene) -> void:
	var laser : Laser = laser_scn.instantiate(level)
	laser.load_weapon(level)
	laser.global_position = player.global_position
	laser_spawner.add_child(laser)


func spawn_enemy(stage : int) -> void:
	for i in range(stage):
		var enemy : Enemy = ENEMY.instantiate()
		enemy.killed.connect(on_enemy_killed)
		enemy.global_position = Vector2(randf_range(0, 1152), randf_range(-100, -0))
		enem_spawner.add_child(enemy)


func on_enemy_killed() -> void:
	kill_count += 1
	kill_label.text = "Kills: " + str(kill_count)
	
	if kill_count % 10 == 0 && level <= 4:
		level += 1
	

func _on_stage_timer_timeout() -> void:
	stage += 1
	stage_label.text = "Stage: " + str(stage)
	spawn_enemy(stage)


func _on_save_quit_button_pressed() -> void:
	var new_save_data : GameData = GameData.new()
	new_save_data.kill_count = kill_count
	new_save_data.level = level
	new_save_data.stage = stage
	ResourceSaver.save(new_save_data, "res://Resources/save_data.tres")
	get_tree().quit()


func _on_restart_button_pressed() -> void:
	var new_save_data : GameData = GameData.new()
	new_save_data.kill_count = 0
	new_save_data.level = 1
	new_save_data.stage = 1
	ResourceSaver.save(new_save_data, "res://Resources/save_data.tres")
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
