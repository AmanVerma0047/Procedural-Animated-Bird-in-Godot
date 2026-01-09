extends Node2D

@export_range(1.0,500.0,1.0) var scale_x := 300.0
@export_range(1.0,500.0,1.0) var scale_y := 150.0
@export var step := 0.01
@export_range(1.0,50.0,1.0) var FLAPPING_SPEED = 1.0
var t := 0.0

func _process(delta):
	t += delta
	queue_redraw()

func _draw():
	var points: PackedVector2Array = []
	#[-0.5,-0.4,-0.3,-0.2,-0.1,0.0,0.1,0.2,0.3,0.4,0.5]
	for i in range(-5,6):
		var x = i*0.1
		var y = abs(x) * sin(abs(x) - FLAPPING_SPEED*t)
#
		## Convert math space → screen space
		var screen_x = x * scale_x
		var screen_y = -y * scale_y

		points.append(Vector2(screen_x, screen_y))

	
	var center = get_viewport_rect().size / 2
	for i in points.size():
		points[i] += center

	draw_polyline(points, Color.WHITE, 3.0)
