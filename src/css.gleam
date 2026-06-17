import gleam/int

pub const float_right = #("float", "right")
pub const text_base = #("font-size", "1rem")
pub const leading_none = #("line-height", "1")
pub const inline_block = #("display", "inline-block")

type StringStyle =
  #(String, String)

pub type BorderStyle {
  String(String)
  None
  Hidden
  Dotted
  Dashed
  Solid
  Double
  Groove
  Ridge
  Inset
  Outset
}

fn border_style_map(style: BorderStyle) -> String {
  case style {
    String(s) -> s
    None -> "none"
    Hidden -> "hidden"
    Dotted -> "dotted"
    Dashed -> "dashed"
    Solid -> "solid"
    Double -> "double"
    Groove -> "groove"
    Ridge -> "ridge"
    Inset -> "inset"
    Outset -> "outset"
  }
}

pub fn border_int(size: Int, style: BorderStyle, color: String) -> StringStyle {
  border(int.to_string(size) <> "px", style, color)
}

pub fn border(size: String, style: BorderStyle, color: String) -> StringStyle {
  #(
    "border",
    size <> " " <> border_style_map(style) <> " " <> color,
  )
}

pub fn border_left(border: String) -> StringStyle {
  #("border-left", border)
}

pub fn color(color: String) -> StringStyle {
  #("color", color)
}

pub fn background(color: String) -> StringStyle {
  #("background", color)
}

pub fn min_height(height: String) -> StringStyle {
  #("min-height", height)
}

pub fn min_width(width: String) -> StringStyle {
  #("min-width", width)
}

pub fn max_width(width: String) -> StringStyle {
  #("max-width", width)
}

pub fn width(width: String) -> StringStyle {
  #("width", width)
}

pub fn padding(size: String) -> StringStyle {
  #("padding", size)
}

pub fn padding_top(size: String) -> StringStyle {
  #("padding-top", size)
}

pub fn padding_bottom(size: String) -> StringStyle {
  #("padding-bottom", size)
}

pub fn padding_left(size: String) -> StringStyle {
  #("padding-left", size)
}

pub fn vertical_align(align: String) -> StringStyle {
  #("vertical-align", align)
}

pub fn margin(val: String) -> StringStyle {
  #("margin", val)
}

pub fn margin_bottom(val: String) -> StringStyle {
  #("margin-bottom", val)
}

pub fn margin_right(val: String) -> StringStyle {
  #("margin-right", val)
}

pub fn margin_top(val: String) -> StringStyle {
  #("margin-top", val)
}

pub fn font_size(size: String) -> StringStyle {
  #("font-size", size)
}

pub fn font_weight(weight: Int) -> StringStyle {
  #("font-weight", int.to_string(weight))
}

pub fn line_height(height: String) -> StringStyle {
  #("line_height", height)
}

pub fn white_space(white_space: String) -> StringStyle {
  #("white-space", white_space)
}