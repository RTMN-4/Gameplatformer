extends Node3D

@onready var label: Label = $CanvasLayer/Label

func _ready():
	# แสดงข้อความตลอดเวลา
	label.text = "จัดทำโดย นายรัชพล ธนาปฏิ 663380292-4"
	label.visible = true
