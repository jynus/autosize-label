@icon("res://addons/autosize_label/AutosizeLabel.svg")
@tool
class_name AutosizeLabel extends Label

## If true, enables the label to be automatically resized to fill its container
## by changing its font size.
@export var autosize : bool = true:
	set(value):
		autosize = value
		if value:
			_refresh_font_size()
		else:
			_initialize_default_font_size()

## Lower limit of the automatic font size
@export var font_size_min: int = 8:
	set(value):
		font_size_min = value
		_refresh_font_size()

## Upper limit of the automatic font size
@export var font_size_max: int = 200:
	set(value):
		font_size_max = value
		_refresh_font_size()

## Percentage of width that the text occupies, from 0% to 100%
@export_range(0, 100) var margin_width: float = 10.0:
	set(value):
		margin_width = value
		_refresh_font_size()

## Percentage of height that the text occupies, from 0% to 100%
@export_range(0, 100) var margin_height: float = 10.0:
	set(value):
		margin_height = value
		_refresh_font_size()

## Default size when not autosized
@export var default_font_size: float = 16:
	set(value):
		default_font_size = value
		_initialize_default_font_size()
		_refresh_font_size()

## Internal variable with the value of the size after autosizing it
var _calculated_font_size: float

## Called when the label enters the tree
func _ready() -> void:
	resized.connect(_on_resized)
	_initialize_default_font_size()
	# default to center/center on the editor
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_refresh_font_size()

## Initialize the default size at start or if autosized disabled
func _initialize_default_font_size() -> void:
	set_font_size(default_font_size)

## Set the right size override
func set_font_size(size: float) -> void:
	if label_settings:
		label_settings.font_size = size
	else:
		add_theme_font_size_override("font_size", size)

## Recalculate optimal font size and apply it (if autosize enabled)
func _refresh_font_size() -> void:
	if not autosize:
		return

	_calculated_font_size = _get_optimal_font_size()
	set_font_size(_calculated_font_size)

## Return optimal size
func _get_optimal_font_size() -> int:
	var width_minus_margin: float = max(0, size.x * (100.0 - margin_width) / 100.0)
	var height_minus_margin: float = max(0, size.y * (100.0 - margin_height) / 100.0)

	var font: Font = get_current_font()
	var font_size: float = font_size_min
	while font_size < font_size_max:
		var text_size = font.get_multiline_string_size(
				text,
				horizontal_alignment,
				-1,
				font_size,
				-1,
				autowrap_mode,
				justification_flags,
				int(text_direction)
		)
		if text_size.x >= width_minus_margin or text_size.y >= height_minus_margin:
			break
		font_size += 1

	return clamp(font_size, font_size_min, font_size_max)

## returns the current active font
func get_current_font() -> Font:
	if label_settings and label_settings.font:
		return label_settings.font
	return get_theme_font("font")

## Monitor text or label settings changes and refresh size calculation
func _set(property: StringName, value: Variant) -> bool:
	match property:
		"text":
			text = value
			_refresh_font_size()
			return true
		"label_settings":
			label_settings = value
			_initialize_default_font_size()
			_refresh_font_size()
			return true
		_:
			return false

## Monitor manual or layout boundary resizes
func _on_resized() -> void:
	_refresh_font_size()
