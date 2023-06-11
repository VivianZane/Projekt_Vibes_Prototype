extends Control


func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -20)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), 20)
	hide()
	



func _on_Back_pressed():
	hide()
	




func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	
func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)	
	
func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)






