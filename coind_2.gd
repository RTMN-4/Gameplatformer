extends Area3D

signal collected

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("collected")   # แจ้งว่า Player เก็บเหรียญ
		queue_free()               # ลบเหรียญออก
