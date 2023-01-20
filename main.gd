extends CanvasLayer

# TODO (Tim Yuen) Godot still can't infer types correctly, so they have to be casted

## Redundant keys for quick access
const OSF_OPTIONS := {
	"IP": {
		"display_name": "IP",
		"flag": "--ip",
		"config_mapping": "ip",
		"hint": "The IP address for sending tracking data"
	},
	"Port": {
		"display_name": "Port",
		"flag": "--port",
		"config_mapping": "port",
		"hint": "The port for sending tracking data"
	},
	"List Cameras": {
		"display_name": "List Cameras",
		"flag": "--list-cameras",
		"config_mapping": "list_cameras",
		"hint": "Set to 1 to list the available cameras and quit. Set to 2 or higher to output only the camera names",
		"windows_only": true
	},
	"List DCaps": {
		"display_name": "List DCaps",
		"flag": "--list-dcaps",
		"config_mapping": "list_dcaps",
		"hint": "Set to -1 to list all cameras and their available capabilities. Set this to a camera ID to list that camera's capabilities.",
		"windows_only": true
	},
	"DCap": {
		"display_name": "DCap",
		"flag": "--dcap",
		"config_mapping": "dcap",
		"hint": "Set which device capability line to use or -1 to use the default camera settings. FPS will still need to be set separately.",
		"windows_only": true
	},
	"Blackmagic": {
		"display_name": "Blackmagic",
		"flag": "--blackmagic",
		"config_mapping": "blackmagic",
		"hint": "Set to 1 to enable Blackmagic device support, if applicable",
		"windows_only": true
	},
	"Width": {
		"display_name": "Width",
		"flag": "--width",
		"config_mapping": "width",
		"hint": "The RGB width"
	},
	"Height": {
		"display_name": "Height",
		"flag": "--height",
		"config_mapping": "height",
		"hint": "The raw RGB height"
	},
	"FPS": {
		"display_name": "FPS",
		"flag": "--fps",
		"config_mapping": "fps",
		"hint": "The capture frames per second"
	},
	"Capture": {
		"display_name": "Capture",
		"flag": "--capture",
		"config_mapping": "capture",
		"hint": "The camera to use (e.g. Windows: 0, 1 Linux: /dev/video0)"
	},
	"Mirror Input": {
		"display_name": "Mirror Input",
		"flag": "--mirror-input",
		"config_mapping": "mirror_input",
		"hint": "If the input should be mirrored before processing",
		"type": TYPE_BOOL
	},
	"Max Threads": {
		
	},
	"Threshold": {
		
	},
	"Detection Threshold": {
		
	},
	"Visualize": {
		
	},
	"PnP Points": {
		
	},
	"Silent": {
		
	},
	"Faces": {
		
	},
	"Scan RetinaFace": {
		
	},
	"Scan Every": {
		
	},
	"Discard After": {
		
	},
	"Max Feature Updates": {
		
	},
	"No 3D Adapt": {
		
	},
	"Try Hard": {
		
	},
	"Video Out": {
		
	},
	"Video Scale": {
		
	},
	"Video FPS": {
		
	},
	"Raw RGB": {
		
	},
	"Log Data": {
		
	},
	"Log Output": {
		
	},
	"Model": {
		
	},
	"Model Directory": {
		
	},
	"Gaze Tracking": {
		
	},
	"Face ID Offset": {
		
	},
	"Repeat Video": {
		
	},
	"Dump Points": {
		
	},
	"Benchmark": {
		
	},
	"Use DShowCapture": {
		"display_name": "Use DShowCapture",
		"flag": "--use-dshowcapture",
		"config_mapping": "use_dshowcapture",
		"hint": "Set to 1 to use libdshowcapture instead of OpenCV",
		"windows_only": true
	},
	"Blackmagic Options": {
		"display_name": "Blackmagic Options",
		"flag": "--blackmagic-options",
		"config_mapping": "blackmagic_options",
		"hint": "An additional option string to be passed to the Blackmagic capture library",
		"windows_only": true
	},
	"Priority": {
		"display_name": "Priority",
		"flag": "--priority",
		"config_mapping": "priority",
		"hint": "The process priority. Options: 0, 1, 2, 3, 4, 5",
		"windows_only": true
	}
}
class OsfOption extends HBoxContainer:
	var _label: Label = null
	var _line_edit: LineEdit = null
	var _element: Control = null
	
	func _init(
		option_name: String,
		option_value: Variant,
		callback: Callable,
		hint: String,
		element_type: int
	) -> void:
		_label = Label.new()
		_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		_label.text = option_name
		
		if element_type == TYPE_STRING:
			_element = LineEdit.new()
			_element.text = option_value
			_element.text_changed.connect(callback)
		else:
			_element = CheckBox.new()
			_element.button_pressed = option_value
			_element.toggled.connect(callback)
		
		_element.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		add_child(_label)
		add_child(_element)
		
		if not hint.is_empty():
			self.tooltip_text = hint
			_label.tooltip_text = hint
			_element.tooltip_text = hint
	
	func option_name() -> String:
		return _label.text
	
	func option_value() -> String:
		return _element.text if _element is LineEdit else _element.button_pressed

var _config: Config = null

@onready
var _status := %Status as RichTextLabel

@onready
var _binary_path := %BinaryPath as LineEdit

@onready
var _python_path := %PythonPath as LineEdit
@onready
var _osf_path := %OsfPath as LineEdit

@onready
var _osf_options := %OsfOptions as VBoxContainer

#-----------------------------------------------------------------------------#
# Builtin functions
#-----------------------------------------------------------------------------#

func _ready() -> void:
	_config = _read_config()
	
	get_viewport().gui_embed_subwindows = false
	
	var run_button := %Run as Button
	run_button.pressed.connect(func() -> void:
		var run_options := []
		for child in _osf_options.get_children():
			run_options.push_back(OSF_OPTIONS[child.option_name()].flag)
			run_options.push_back(child.option_value())
			pass
	)
	
	var binary_options := %BinaryOptions as VBoxContainer
	var python_options := %PythonOptions as VBoxContainer
	
	var run_type := %RunType as OptionButton
	for val in Config.RunTypes.values():
		run_type.add_item(val)
	run_type.item_selected.connect(func(idx: int) -> void:
		match run_type.get_item_text(idx):
			Config.RunTypes.BINARY:
				python_options.hide()
				binary_options.show()
			Config.RunTypes.PYTHON:
				binary_options.hide()
				python_options.show()
	)
	
	%ChooseBinary.pressed.connect(func() -> void:
		var popup := _show_file_dialog()
		popup.file_selected.connect(func(path: String) -> void:
			_binary_path.text = path
		)
	)
	
	%ChoosePython.pressed.connect(func() -> void:
		var popup := _show_file_dialog()
		popup.file_selected.connect(func(path: String) -> void:
			_python_path.text = path
		)
	)
	%ChooseOsf.pressed.connect(func() -> void:
		var popup := _show_file_dialog(FileDialog.FILE_MODE_OPEN_DIR)
		popup.dir_selected.connect(func(path: String) -> void:
			_osf_path.text = path
		)
	)
	
	for data in OSF_OPTIONS.values():
		var option := OsfOption.new(
			data.display_name,
			_config.get(data.config_mapping),
			func(value: Variant) -> void:
				_config.set(data.config_mapping, value),
			data.get("hint", ""),
			data.get("type", TYPE_STRING)
		)
		
		_osf_options.add_child(option)
	
	_update_status("Ready!")

func _exit_tree() -> void:
	_write_config(_config)

#-----------------------------------------------------------------------------#
# Private functions
#-----------------------------------------------------------------------------#

func _update_status(text: String) -> void:
	_status.text = "[right][rainbow][wave]%s[/wave][/rainbow][/right]" % text

func _show_file_dialog(file_mode: int = FileDialog.FILE_MODE_OPEN_FILE) -> FileDialog:
	var popup := FileDialog.new()
	popup.file_mode = file_mode
	popup.access = FileDialog.ACCESS_FILESYSTEM
	
	add_child(popup)
	popup.popup_centered_ratio(0.5)
	
	popup.close_requested.connect(func() -> void:
		popup.queue_free()
	)
	popup.visibility_changed.connect(func() -> void:
		popup.close_requested.emit()
	)
	
	return popup

static func _read_config() -> Config:
	var config: Resource = ResourceLoader.load(Config.SAVE_PATH, "tres")
	if config == null or not config is Config:
		print("Unable to load config, using new config")
		config = Config.new()
	
	return config as Config

static func _write_config(config: Config) -> void:
	if ResourceSaver.save(config, Config.SAVE_PATH, ResourceSaver.FLAG_CHANGE_PATH) != OK:
		printerr("Unable to write config")

#-----------------------------------------------------------------------------#
# Public functions
#-----------------------------------------------------------------------------#

