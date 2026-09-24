extends PanelContainer

class_name builder_tooltip

func setup(title: String, title_icon: CompressedTexture2D, discription_bbcode: String):
	$MarginContainer/VBoxContainer/HBoxContainer/Title.text = title
	$MarginContainer/VBoxContainer/HBoxContainer/Icon.texture = title_icon
	$MarginContainer/VBoxContainer/RichTextLabel.text = discription_bbcode
