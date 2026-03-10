extends Node

var game_controller : GameController # to connect w/ game controller 
var scene_room: String = "Foyer" # set initial room
var day: int = 1 # set first day
var is_night: bool = false # set day time
var time_of_day: String = "Day 1"
var cause_of_death: String
var monsters: Array = ["imp", "skinwalker"]
var imp: bool = false
var skinwalker: bool = false


func monsters_size():
	return monsters.size()
