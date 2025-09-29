extends Area3D

@export var respawn_position: Vector3 = Vector3(0, 2, 0) # ตำแหน่งเกิดใหม่

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Cube Man Character":   # ชน Player
		body.global_transform.origin = respawn_position
		body.velocity = Vector3.ZERO   # รีเซ็ตความเร็ว ไม่ให้ยังคงความแรงตก
