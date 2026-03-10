extends Node2D
var minute: int = -5
var hour: int = 12
var Camera_x: float = 0
var Camera_y: float = 0
var x = 0
var y = 0
var Camera_speed: float = 1
var Camera_intensity: float = 1
var opacity: float = 0
var is_fade_out: bool = false

func _ready():
	_scene_change()
	var clock = $Timer
	Clock()
	clock.timeout.connect(Clock)
	var text_edit = $RichTextLabel3
	text_edit.add_text(str(globals.time_of_day))

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

func day_change():
	globals.day += 1

func night_change():
	if globals.is_night:
		globals.is_night = false
		globals.time_of_day = "Day " + str(globals.day)
	else:
		globals.is_night = true
		globals.time_of_day = "Night " + str(globals.day)
	if globals.is_night:
		pause_clock()
	else:
		pause_clock()
	var text_edit = $RichTextLabel3
	text_edit.clear()
	text_edit.add_text(str(globals.time_of_day))

func pause_clock():
	var clock = $Timer
	clock.set_paused(true)
	var dayButton = Button.new()
	add_child(dayButton)
	dayButton.scale = Vector2(10, 10)
	dayButton.pressed.connect(unpause_clock)
	dayButton.pressed.connect(dayButton.queue_free)

func unpause_clock():
	var clock = $Timer
	clock.set_paused(false)

func _scene_change():
	if has_node("RichTextLabel"):
		var text_edit = $RichTextLabel
		text_edit.clear()
		text_edit.add_text(globals.scene_room)
	opacity = 1
	is_fade_out = true

func _fade():
	var black_screen = $BlackTransition
	black_screen.modulate = Color(1,1,1,opacity)

func _process(delta: float) -> void:
	if globals.new_room != globals.scene_room:
		globals.scene_room = globals.new_room
		_scene_change()
		Camera_x = 0
		Camera_y = 0
		x = 0
		y = 0
		var black_screen = $BlackTransition
		black_screen.modulate = Color(1,1,1,1)
	if is_fade_out:
		if opacity == 0:
			is_fade_out = false
		else:
			opacity -= .01
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
