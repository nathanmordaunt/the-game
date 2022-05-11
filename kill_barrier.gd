extends Area2D

class_name Barrier

func _on_Node2D_body_entered(body):
	# hack; this should be handled on the scene. 
	get_tree().reload_current_scene()
