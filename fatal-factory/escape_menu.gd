extends CanvasLayer

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEvent and Input.is_action_just_pressed("Menu"):
		visible = !visible
	

func _on_resume_pressed() -> void:
	visible = false


func _on_save_game_pressed() -> void:
	Saver.save()


func _on_save_and_quit_pressed() -> void:
	Saver.save()
	get_tree().quit()
