extends CanvasLayer
class_name UILayer

@onready var win_screen = $WinScreen
@onready var hud = $HUD

func display_win_screen(flag: bool) -> void :
	win_screen.visible = flag

