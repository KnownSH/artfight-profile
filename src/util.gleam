//// For things that are not fully a component, but also would look ugly if inlined

import gleam/list
import lustre/element.{type Element}
import lustre/element/html

pub fn quotes(text: String) -> String {
  "\"" <> text <> "\""
}

pub fn bold_italic(text: String) -> Element(Nil) {
  html.em([], [bold(text)])
}

pub fn bold(text: String) -> Element(Nil) {
  html.strong([], [html.text(text)])
}

pub fn multi_br(count count: Int) -> Element(Nil) {
  list.repeat(html.br([]), times: count)
  |> element.fragment
}
