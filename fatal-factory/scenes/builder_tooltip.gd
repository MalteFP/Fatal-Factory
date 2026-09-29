extends PanelContainer

func setup(title: String, title_icon: CompressedTexture2D):
	$MarginContainer/VBoxContainer/HBoxContainer/Title.text = title
	$MarginContainer/VBoxContainer/HBoxContainer/Icon.texture = title_icon
