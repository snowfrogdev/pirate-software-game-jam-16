@tool
extends Timer

func _ready():
	if Engine.is_editor_hint():
		start()
