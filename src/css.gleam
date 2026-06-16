import gleam/int

pub const float_right = #("float", "right")
pub const text_base = #("font-size", "1rem")

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

pub fn background(color: String) -> StringStyle {
  #("background", color)
}

pub fn min_height(height: String) -> StringStyle {
  #("min-height", height)
}

pub fn max_width(height: String) -> StringStyle {
  #("max-width", height)
}

pub fn padding(size: String) -> StringStyle {
  #("padding", size)
}

pub fn vertical_align(align: String) -> StringStyle {
  #("vertical-align", align)
}