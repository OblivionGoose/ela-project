extends Node2D

@onready var clock = $Timer
@onready var audio = $AudioStreamPlayer
@onready var black_screen = $BlackTransition
@onready var text_room = $RichTextLabel
@onready var clock_text = $RichTextLabel2
@onready var text_daytime = $RichTextLabel3
@onready var monster_text = $RichTextLabel4
@onready var monster_text2 = $RichTextLabel5
@onready var nightchange_text = $RichTextLabel6
var rng = RandomNumberGenerator.new()
var clock_speed = 0.02
var minute: int = 0
var hour: int = 12
var Camera_x: float = 0
var Camera_y: float = 0
var x = 0
var y = 0
var Camera_speed: float = 1
var Camera_intensity: float = 1
var loop: bool = true
var opacity: float = 0
var is_fade_out: bool = false
var is_fade_in: bool = false
var spawn_rate: int = 20
var imps_killed: int = 0
var skinwalker_killed: int = 0

func _ready():
	_scene_change()
	Clock()
	print("HI")
	clock.timeout.connect(Clock)
	text_daytime.add_text(str(globals.time_of_day))
	rng.randomize()
	clock_text.modulate = Color(0,0,0,1)
	Clock()

func Clock():
	if globals.is_night:
		clock.start()
		minute += 5
		print("tick") 
	
	if globals.is_night:
		random_monster_summon()
	
	var clockMinute = "00"
	var clockHour = "00"
	if minute == 60:
		minute = 0
		hour += 1
	if hour == 24:
		hour = 0
		day_change()
	if hour < 10:
		clockHour = "0" + str(hour)
	else:
		clockHour = str(hour)
	if minute < 10:
		clockMinute = "0" + str(minute)
	else:
		clockMinute = str(minute)
	globals.hour = hour
	globals.minute = minute
	if hour == 6 && minute == 0:
		night_change()
	if hour == 21 && minute == 0:
		night_change()
		unpause_clock()
	print(clockHour + ":" + clockMinute)
	print(globals.hour + globals.minute)
	clock_text.clear()
	clock_text.add_text(clockHour + ":" + clockMinute)

func time_change(added_time: int):
	var new_time: int
	new_time = hour + (minute+added_time)/60 # error is intended
	if new_time > 21:
		printerr("Error! time added surpassed the nighttime cut off at hour 21")
		hour = 21 
		minute = 0
		Clock()
	elif new_time == 21:
		if (minute + added_time) % 60 != 0:
			printerr("Error! time added surpassed the nighttime cut off at minute 00 (hour 21)")
			hour = 21 
			minute = 0
			Clock()
		else:
			minute = (minute + added_time) - (new_time - hour)*60 
			hour = new_time
			Clock()
			print("added " + str(added_time) + " minutes successfully!")

	else:
		minute = (minute + added_time) - (new_time - hour)*60 
		hour = new_time
		Clock()
		print("added " + str(added_time) + " minutes successfully!")


# called when time is 00:00, i.e the day changes calendar-wise
func day_change():
	globals.day += 1

func night_change():
	if globals.is_night:
		globals.is_night = false
		globals.time_of_day = "Day " + str(globals.day)
	else:
		globals.is_night = true
		globals.time_of_day = "Night " + str(globals.day)
	if globals.scene_room == "Foyer":
		var room = $Foyer_Room
		room.unbutton()
	elif globals.scene_room == "Basement":
		var room = $Basement_room
		room.unbutton()
	elif globals.scene_room == "Bathroom":
		var room = $bathroom
		room.unbutton()
	elif globals.scene_room == "Bedroom":
		var room = $bedroom
		room.unbutton()
	elif globals.scene_room == "Kitchen":
		var room = $Kitchen_room
		room.unbutton()
	elif globals.scene_room == "Living":
		var room = $living
		room.unwindow()
		room.unbutton()
	elif globals.scene_room == "Study":
		var room = $Study_room
		room.unwindow()
		room.unbutton()
	else:
		var room = $Upstairs_hallway
		room.unbutton()
		
	nightchange_text.show()
	# process day to night transition
	if globals.is_night:
		print("changing to night")
		is_fade_out = false
		is_fade_in = true
		audio.play()
		nightchange_text.clear()
		nightchange_text.add_text(globals.time_of_day)
		clock.timeout.disconnect(Clock)
		clock.set_wait_time(5.0)
		clock.start()
		clock.timeout.connect(night_transition)
	# process night to day transition
	else:
		print("changing to day")
		is_fade_out = false
		is_fade_in = true
		audio.play()
		nightchange_text.clear()
		nightchange_text.add_text(globals.time_of_day)
		clock.timeout.disconnect(Clock)
		clock.set_wait_time(5.0)
		hour = 14
		clock.start()
		clock.timeout.connect(night_transition)
	text_daytime.clear()
	text_daytime.add_text(str(globals.time_of_day))

func night_transition():
	is_fade_out = true
	print("night_transition" + str(clock.get_wait_time()))
	clock.timeout.disconnect(night_transition)
	clock.set_wait_time(5)
	clock.timeout.connect(reconnect_clock)

func day_transition():
	is_fade_out = true
	print("night_transition" + str(clock.get_wait_time()))
	clock.timeout.disconnect(day_transition)
	clock.set_wait_time(5)
	clock.timeout.connect(reconnect_clock)

func reconnect_clock():
	if clock.timeout.is_connected(night_transition):
		clock.timeout.disconnect(night_transition)
	if clock.timeout.is_connected(day_transition):
		clock.timeout.disconnect(day_transition)
	clock.timeout.disconnect(reconnect_clock)
	clock.timeout.connect(Clock)
	clock.set_wait_time(clock_speed)
	if globals.is_night:
		print("here?")
		clock.start()
	else:
		pause_clock()
		Clock()
	opacity = 0
	_fade()
	is_fade_in = false
	is_fade_out = false
	nightchange_text.hide()
	if globals.scene_room == "Foyer":
		var room = $Foyer_Room
		room.rebutton()
	elif globals.scene_room == "Basement":
		var room = $Basement_room
		room.rebutton()
	elif globals.scene_room == "Bathroom":
		var room = $bathroom
		room.rebutton()
	elif globals.scene_room == "Bedroom":
		var room = $bedroom
		room.rebutton()
	elif globals.scene_room == "Kitchen":
		var room = $Kitchen_room
		room.rebutton()
	elif globals.scene_room == "Living":
		var room = $living
		room.rebutton()
	elif globals.scene_room == "Study":
		var room = $Study_room
		room.rebutton()
	else:
		var room = $Upstairs_hallway
		room.rebutton()
		
	print("reconnected clock")

# Summons a monster at random, frequency and monster type depend on days
func random_monster_summon():
	if globals.imp:
		loop = false
	var random: int
	random = rng.randi_range(0, spawn_rate)
	if random == 0:
		while loop:
			loop = false
			random = rng.randi_range(0, globals.monsters_size() - 1)
			if random == 0:
				if !globals.imp: # summon imp
					var imp = load("res://scenes/Monsters/imp.tscn").instantiate()
					add_child(imp)
					monster_text.clear()
					monster_text.add_text(globals.monsters[0])
					imp.imp_dies.connect(imp_dies)
					imp.imp_kills.connect(game_over)
				else :
					loop = true
			elif random == 1:
				if !globals.skinwalker: # summon skinwalker
					var skinwalker = load("res://scenes/Monsters/skinwalker.tscn").instantiate()
					add_child(skinwalker)
					monster_text2.clear()
					monster_text2.add_text(globals.monsters[1])
					skinwalker.skinwalker_dies.connect(skinwalker_dies)
					skinwalker.skinwalker_kills.connect(game_over)
				else :
					loop = true
			elif random == 2:
				pass #summon whatever else...
			else:
				loop = true
	loop = true


func game_over(cause_of_death: String = "imp"):
	text_room.clear()
	monster_text.clear()
	monster_text.add_text("haha idiot, you died from " + globals.cause_of_death + "
	 What a loser lololololol. ")
	clock.queue_free()
	if globals.scene_room == "Bedroom":
		var room = $bedroom
		room.hide()
	if globals.imp:
		var monster = $Imp
		monster.queue_free()
	if globals.skinwalker:
		var monster2 = $Skinwalker
		monster2.queue_free()

func imp_dies():
	imps_killed += 1
	monster_text.add_text(" killed: " + str(imps_killed))

func skinwalker_dies():
	skinwalker_killed += 1
	monster_text2.add_text(" killed:" + str(skinwalker_killed))

# called whenever the clock needs to pause. calls unpause_clock later
func pause_clock():
	print("paused")
	clock.set_paused(true)

func unpause_clock(): #what do you think
	print("unpaused")

	clock.set_paused(false)

func _scene_change():
	print("changing scenes")
	text_room.clear()
	text_room.add_text(globals.scene_room)
	opacity = 1
	is_fade_out = true
	Camera_x = 0
	Camera_y = 0
	x = 0
	y = 0
	black_screen.modulate = Color(1,1,1,1) 


func _fade():
	print("fading")
	black_screen.modulate = Color(1,1,1,opacity)
	if nightchange_text.visible:
		nightchange_text.modulate = Color(1,1,1,opacity)

func _process(delta: float) -> void:
# processes the fading out sequence
	if is_fade_out:
		if opacity == 0:
			is_fade_out = false
		else:
			opacity -= .0078125
			print("fading_out")
			_fade()
# processes the fading in sequence
	if is_fade_in:
		if opacity == 1:
			is_fade_in = false
		else:
			opacity += .0078125
			print("fading in")
			_fade()
	var Camera = $Camera2D
	x += delta * Camera_speed/2
	y += delta * Camera_speed/2
	Camera_x += cos(x) * Camera_intensity * Camera_speed / 14.19
	Camera_y += sin(y) * Camera_intensity * Camera_speed / 8
	Camera.set_offset(Vector2(Camera_x, Camera_y))

func _input(event):
	if event is InputEventKey and event.pressed:
		if Input.is_action_just_pressed("inventory"):
			print("E pressed from World2d!")
			var inventory_ui = $CanvasLayer/InventoryUI
			if inventory_ui.visible:
				inventory_ui.hide()
			else:
				inventory_ui.show()
				var grid = inventory_ui.get_node("GridContainer")
				for child in grid.get_children():
					child.queue_free()
				for slot in get_node("/root/GameManager").player_inventory.slots:
					var slot_ui = preload("res://item_slot.tscn").instantiate()
					slot_ui.setup(slot["item"], slot["quantity"])
					grid.add_child(slot_ui)


func _on_add_5_minutes_pressed():
	time_change(5)

func _on_add_30_minutes_pressed() -> void:
	time_change(30)


func _on_timer_timeout() -> void:
	print("timeout")
