extends CharacterBody3D

# ---------------- CONFIG ---------------- #
@export var speed := 5.0                # ความเร็ววิ่ง
@export var jump_velocity := 10.0       # ความสูงกระโดด
@export var camera_distance := 6.0      # ระยะกล้อง
@export var camera_height := 3.0        # ความสูงกล้อง

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# ---------------- NODES ---------------- #
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var armature: Node3D = $CharacterArmature
@onready var camera: Camera3D = $Camera3D

# ---------------- READY ---------------- #
func _ready():
	# ใส่ Player เข้า Group เพื่อให้ Coin ตรวจจับได้
	add_to_group("Cube Man Character")

	# ตั้งค่ากล้องให้อยู่ด้านหลังตัวละคร
	camera.transform.origin = Vector3(0, camera_height, camera_distance)
	camera.look_at(global_transform.origin, Vector3.UP)

	# เริ่มที่ Idle
	if anim_player.has_animation("Idle"):
		anim_player.play("Idle")

# ---------------- PHYSICS ---------------- #
func _physics_process(delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# -------- MOVE -------- #
	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

		# หันเฉพาะแกน Y
		var target = global_transform.origin + direction
		target.y = global_transform.origin.y
		armature.look_at(target, Vector3.UP)

		# หมุนกลับ 180 องศา (ป้องกันหันหลัง)
		armature.rotate_y(deg_to_rad(180))

		# เล่นอนิเมชัน Run
		if is_on_floor() and anim_player.has_animation("Run"):
			if anim_player.current_animation != "Run":
				anim_player.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

		# เล่นอนิเมชัน Idle
		if is_on_floor() and anim_player.has_animation("Idle"):
			if anim_player.current_animation != "Idle":
				anim_player.play("Idle")

	# -------- JUMP -------- #
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
			if anim_player.has_animation("Jump"):
				anim_player.play("Jump")
	else:
		velocity.y -= gravity * delta

	# เคลื่อนที่
	move_and_slide()
