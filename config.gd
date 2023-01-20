class_name Config
extends Resource

# TODO (Tim Yuen) Must be in a seperate file otherwise Godot cannot load the resource

const SAVE_PATH := "user://osfgd_config.tres"

const RunTypes := {
	"BINARY": "Binary",
	"PYTHON": "Python"
}

@export
var run_type := RunTypes.BINARY

@export
var binary_path := ""

@export
var python_path := ""
@export
var osf_path := ""

@export
var ip := ""
@export
var port := ""
@export
var width := ""
@export
var height := ""
@export
var fps := ""
@export
var capture := ""
@export
var mirror_input := false
