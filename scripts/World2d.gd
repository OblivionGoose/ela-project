extends Node2D

var minute: int = -5
var hour: int = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	_scene_change()
	var clock = $Timer
	Clock()
	clock.timeout.connect(Clock)
	var text_edit = $RichTextLabel3
	text_edit.add_text(str(globals.time_of_day))

# Calls the timer node to simulate a military analog clock.
# change timer wait to change the speed of time, wait time = 5 minutes in game
func Clock():
	var clock = $Timer
	clock.start()
	var clock_text = $RichTextLabel2
	var clockMinute = "00"
	var clockHour = "00"
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
	var text_edit = $RichTextLabel3
	text_edit.clear()
	text_edit.add_text(str(globals.time_of_day))

# called whenever the clock needs to pause. call unpause_clock later
func pause_clock():
	var clock = $Timer
	clock.set_paused(true)
	var dayButton = Button.new() 
	add_child(dayButton)
	dayButton.scale = Vector2(10, 10)
	dayButton.pressed.connect(unpause_clock) # unpause and remove button on pressed
	dayButton.pressed.connect(dayButton.queue_free)

func unpause_clock():
	var clock = $Timer
	clock.set_paused(false)


# Called when script detects a scene change
func _scene_change():
	var text_edit = $RichTextLabel
	text_edit.clear()
	text_edit.add_text(globals.scene_room)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if globals.new_room != globals.scene_room:
		globals.scene_room = globals.new_room
		_scene_change()
