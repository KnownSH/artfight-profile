import gleam/list
import gleam/dict.{type Dict}
import ini
import lustre/attribute

pub type SlassStylesheet =
  Dict(String, String)

pub type SlassGetter =
  fn(List(String)) -> attribute.Attribute(Nil)

pub fn read(
  from path: String,
  vars variables: Dict(String, String),
) -> SlassStylesheet {
  ini.read(path, variables)
  |> dict.fold(from: dict.new(), with: fn(acc, key, value) {
    let computed_style =
      dict.fold(value, "", fn(style, prop, style_value) {
        style <> prop <> ":" <> style_value <> ";"
      })
    dict.insert(acc, key, computed_style)
  })
}

pub fn getter(style stylesheet: SlassStylesheet) -> SlassGetter {
  fn(classes: List(String)) {
    let merged = list.fold(classes, "", with: fn(style, class) {
      let assert Ok(val) = dict.get(stylesheet, class)
      style <> val
    })
    attribute.attribute("style", merged)
  }
}
