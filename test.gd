extends Node2D

@export_range(1.0, 200.0, 1.0) var amplitude := 50.0
@export_range(0.1, 10.0, 0.1) var flapping_speed := 5.0


var t := 0.0
var base_points: PackedVector2Array

@onready var wings: Line2D = $wings
func _ready():
	base_points = wings.points.duplicate()
	
func _process(delta):
	
	t += delta

	animate_wings()
	
func animate_wings():
	var new_points := PackedVector2Array()
	for i in base_points.size():
		var p = base_points[i]
		
		# Normalize X for sine (-1 to 1 range)
		var x_norm = p.x / base_points[-1].x
		# Bird equation
		var y_offset = abs(x_norm) * sin(abs(x_norm) - flapping_speed * t)
		new_points.append(Vector2(
			p.x,
			p.y - y_offset * amplitude
		))
	wings.points = new_points
