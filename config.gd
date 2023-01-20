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
var ip := "127.0.0.1"
@export
var port := "11573"
@export
var list_cameras := "0"
@export
var list_dcaps := ""
@export
var width := "640"
@export
var height := "360"
@export
var dcap := ""
@export
var blackmagic := "0"
@export
var fps := "24"
@export
var capture := "0"
@export
var mirror_input := false
@export
var max_threads := "1"
@export
var threshold := ""
@export
var detection_threshold := "0.6"
@export
var visualize := "0"
@export
var pnp_points := "0"
@export
var silent := "0"
@export
var faces := "1"
@export
var scan_retinaface := "0"
@export
var scan_every := "3"
@export
var discard_after := "10"
@export
var max_feature_updates := "900"
@export
var no_3d_adapt := "1"
@export
var try_hard := "0"
@export
var video_out := ""
@export
var video_scale := "1"
@export
var video_fps := "24"
@export
var raw_rgb := "0"
@export
var log_data := ""
@export
var log_output := ""
@export
var model := "3"
@export
var model_dir := ""
@export
var gaze_tracking := "1"
@export
var face_id_offset := "0"
@export
var repeat_video := "0"
@export
var dump_points := ""
@export
var benchmark := "0"
@export
var use_dshowcapture := "1"
@export
var blackmagic_options := ""
@export
var priority := ""
