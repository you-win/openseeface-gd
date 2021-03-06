class_name ButtonLabel
extends BaseMenuItem

onready var button: Button = $MarginContainer/HBoxContainer/Button

var button_disabled: bool = false
var button_text: String

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	button.disabled = button_disabled
	
	if button_text:
		button.text = button_text

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func link_to_function(object: Object, function_name: String) -> void:
	"""
	Inputs are programmatically assigned, so we need this function
	"""
	# TODO this is kinda gross
	if not button:
		yield(self, "ready")
	button.connect("pressed", object, function_name)

func get_value():
	AppManager.log_message("Tried to get value on %s, access the name property instead" % self.name)
