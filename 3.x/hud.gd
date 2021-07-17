extends Control

onready var fps_label := $FPSLabel as Label
onready var directional_light_status := $VBoxContainer/DirectionalLightStatus as Label
onready var omni_lights_status := $VBoxContainer/OmniLightsStatus as Label
onready var msaa_status := $VBoxContainer/MSAAStatus as Label
onready var fxaa_status := $VBoxContainer/FXAAStatus as Label
onready var ssao_status := $VBoxContainer/SSAOStatus as Label
onready var glow_status := $VBoxContainer/GlowStatus as Label


func _process(delta: float) -> void:
	var fps := Engine.get_frames_per_second()
	fps_label.text = "%d FPS (%.1f ms)" % [fps, 1000.0 / max(1, fps)]


func _input(event) -> void:
	var environment := $"/root/Test/WorldEnvironment".environment as Environment
	var directional_light := $"/root/Test/DirectionalLight" as DirectionalLight
	var omni_lights := $"/root/Test/OmniLights" as Spatial

	if event.is_action_pressed("toggle_directional_light"):
		directional_light.visible = not directional_light.visible
		directional_light_status.text = "DirectionalLight: Visible" if directional_light.visible else "DirectionalLight: Hidden"

	if event.is_action_pressed("toggle_omni_lights"):
		omni_lights.visible = not omni_lights.visible
		omni_lights_status.text = "OmniLights: Visible" if omni_lights.visible else "OmniLights: Hidden"

	if event.is_action_pressed("toggle_msaa"):
		get_viewport().msaa = Viewport.MSAA_DISABLED if get_viewport().msaa else Viewport.MSAA_4X
		msaa_status.text = "MSAA: Enabled (4×)" if get_viewport().msaa else "MSAA: Disabled"

	if event.is_action_pressed("toggle_fxaa"):
		get_viewport().fxaa = not get_viewport().fxaa
		fxaa_status.text = "FXAA: Enabled" if get_viewport().fxaa else "FXAA: Disabled"

	if event.is_action_pressed("toggle_ssao"):
		environment.ssao_enabled = not environment.ssao_enabled
		ssao_status.text = "SSAO: Enabled" if environment.ssao_enabled else "SSAO: Disabled"

	if event.is_action_pressed("toggle_glow"):
		environment.glow_enabled = not environment.glow_enabled
		glow_status.text = "Glow: Enabled" if environment.glow_enabled else "Glow: Disabled"
