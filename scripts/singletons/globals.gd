extends Node

var game_controller : GameController # to connect w/ game controller 

var scene_room: String = "Foyer" # set initial room
var new_room: String = "Foyer"
var day: int = 1 # set first day
var is_night: bool = false # set day time
var time_of_day: String = "Day 1"
var monsters: String
