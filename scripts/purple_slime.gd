extends Slime
@onready var floor_collision_right = %FloorCollisionCheckRight
@onready var floor_collision_left = %FloorCollisionCheckLeft

func _handle_goomba() -> void:
	var collider = _ray_cast_goomba.get_collider()
	if collider.has_method("_on_purple_goombaed"):
		collider.call("_on_purple_goombaed")
	queue_free()

func _process(_delta: float) -> void:
	super._process(_delta)
	if not floor_collision_right.has_overlapping_bodies(): 
		_direction = -1	
	elif not floor_collision_left.has_overlapping_bodies(): 
		_direction = 1	
	
