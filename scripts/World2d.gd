extends Node2D

@onready var clock = $Timer
@onready var black_screen = $BlackTransition
@onready var text_room = $RichTextLabel
@onready var clock_text = $RichTextLabel2
@onready var text_daytime = $RichTextLabel3
@onready var monster_text = $RichTextLabel4
@onready var monster_text2 = $RichTextLabel5
var rng = RandomNumberGenerator.new()
var minute: int = -5
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
var spawn_rate: int = 20
var imps_killed: int = 0
var skinwalker_killed: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_scene_change()
	Clock()
	clock.timeout.connect(Clock)
	text_daytime.add_text(str(globals.time_of_day))
	rng.randomize()
	clock_text.modulate = Color(0,0,0,1)

# Calls the timer node to simulate a military analog clock.
# change timer wait to change the speed of time, wait time = 5 minutes in game
func Clock():
	clock.start()
	var clockMinute = "00"
	var clockHour = "00"
	var random = RandomNumberGenerator.new()
	random.randomize()
	minute = minute + 5
	if minute == 60:
		minute = 0
		hour += + 1
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
	if hour == 6 && minute == 0:
		night_change()
	if hour == 21 && minute == 0:
		night_change()
	clock_text.clear()
	clock_text.add_text(clockHour + ":" + clockMinute)
	
	if globals.is_night:
		random_monster_summon()

# called when time is 00:00, i.e the day changes calendar-wise
func day_change():
	globals.day += 1

# Called whenever daybreaks or nightfalls
func night_change():
	if globals.is_night: #invert current bool value of is_night 
		globals.is_night = false
		globals.time_of_day = "Day " + str(globals.day)
	else:
		globals.is_night = true
		globals.time_of_day = "Night " + str(globals.day)
	# process day to night transition
	if globals.is_night:
		pause_clock()
	# process night to day transition
	else:
		pause_clock()
	text_daytime.clear()
	text_daytime.add_text(str(globals.time_of_day))
	

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
	clock.set_paused(true)
	var dayButton = Button.new() 
	add_child(dayButton)
	dayButton.scale = Vector2(10, 10)
	dayButton.pressed.connect(unpause_clock) # unpause and remove button on pressed
	dayButton.pressed.connect(dayButton.queue_free)

func unpause_clock(): #what do you think
		clock.set_paused(false)

# Called when script detects a scene change
func _scene_change():
	text_room.clear()
	text_room.add_text(globals.scene_room)
	opacity = 1
	is_fade_out = true
	Camera_x = 0
	Camera_y = 0
	x = 0
	y = 0
	black_screen.modulate = Color(1,1,1,1)


# Called whenever the black screen needs to fade in or out.
func _fade():
	black_screen.modulate = Color(1,1,1,opacity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
# processes the fading out sequence
	if is_fade_out:
		if opacity == 0:
			is_fade_out = false
		else:
			opacity -= .02
			_fade()
# Processes idle Camera movement. 
	var Camera = $Camera2D
	x += delta * Camera_speed/2
	y += delta * Camera_speed/2
	Camera_x += cos(x) * Camera_intensity * Camera_speed / 14.19
	Camera_y += sin(y) * Camera_intensity * Camera_speed / 8
	Camera.set_offset(Vector2(Camera_x, Camera_y))
