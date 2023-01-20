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
var list_cameras := ""
@export
var list_dcaps := ""
@export
var width := ""
@export
var height := ""
@export
var dcap := ""
@export
var blackmagic := ""
@export
var fps := ""
@export
var capture := ""
@export
var mirror_input := false
@export
var max_threads := ""
@export
var threshold := ""
@export
var detection_threshold := ""
@export
var visualize := ""
@export
var pnp_points := ""
@export
var silent := ""
@export
var faces := ""
@export
var scan_retinaface := ""
@export
var scan_every := ""
@export
var discard_after := ""
@export
var max_feature_updates := ""
@export
var no_3d_adapt := ""
@export
var try_hard := ""
@export
var video_out := ""
@export
var video_scale := ""
@export
var video_fps := ""
@export
var raw_rgb := ""
@export
var log_data := ""
@export
var log_output := ""
@export
var model := ""
@export
var model_dir := ""
@export
var gaze_tracking := ""
@export
var face_id_offset := ""
@export
var repeat_video := ""
@export
var dump_points := ""
@export
var benchmark := ""
@export
var use_dshowcapture := ""
@export
var blackmagic_options := ""
@export
var priority := ""
