import gleam/dict.{type Dict}
import gleam/list
import ini
import lustre/attribute

pub type SlassStylesheet =
  Dict(String, String)

pub type SlassGetter =
  fn(List(String)) -> attribute.Attribute(Nil)

pub fn read(
  from path: String,
  using variables: Dict(String, String),
) -> SlassStylesheet {
  let ini_file = ini.read(path, variables)
  use acc, class_name, properties <- dict.fold(ini_file, dict.new())

  let computed_style = {
    use style_acc, property, value <- dict.fold(properties, "")
    style_acc <> property <> ":" <> value <> ";"
  }

  dict.insert(acc, class_name, computed_style)
}

pub fn getter(style stylesheet: SlassStylesheet) -> SlassGetter {
  fn(classes: List(String)) {
    let style_attribute = attribute.attribute("style", _)

    list.fold(classes, "", with: fn(acc, class) {
      case dict.get(stylesheet, class) {
        Ok(style_str) -> acc <> style_str
        Error(_) -> acc
      }
    })
    |> style_attribute
  }
}
