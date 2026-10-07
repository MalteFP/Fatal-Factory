extends Control
var tutorialStage;
var tutorialMessages = [
	"Hello and welcome to the world of Fatal Factory!",
	"Your mission is to drain all ressourcer from the planet.",
	"To get started, click on 'Drill' in the buildings menu to select it for construction.",
	"Now place it on the ground near the Hub to start drilling.",
	"Good job! You are now exploting the planet for your own financial gain.",
	"To collect the ressourcer you must build a line of conveyors to transport the dirt to the Hub.",
	"Press 'R' to rotate the conveyor or press 'T' to mirror it horizontally.",
	"If you want to remove a building, press 'D' to enable sell mode.",
	"Selling a building will refund half of the resources used to contruct it and remove it from the map.",
	"Your drills require energy to work. To get energy you must build a Generator.",
	"A generator needs an animal to produce energy. Press on of the Hamsters running around to capture it.",
	"Well Done! You can now build a generator. Place it anywhere to start producing energy, no transportation needed"
	
	
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tutorialStage = 0 # Replace with function body.
	$CanvasLayer/Label.text = tutorialMessages[tutorialStage]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Next Tutorial"):
		tutorialStage += 1
		$CanvasLayer/Label.text = tutorialMessages[tutorialStage]
		
