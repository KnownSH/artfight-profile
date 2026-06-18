//// For things that are not fully a component, but also would look ugly if inlined

import css
import gleam/int
import gleam/list
import lustre/attribute
import lustre/element
import lustre/element/html

type Element =
  element.Element(Nil)

pub fn quotes(text: String) -> String {
  "\"" <> text <> "\""
}

pub fn bold_italic(text: String) -> Element {
  html.em([], [bold(text)])
}

pub fn bold(text: String) -> Element {
  html.strong([], [html.text(text)])
}

pub fn multi_br(count count: Int) -> Element {
  list.repeat(html.br([]), times: count)
  |> element.fragment
}

pub fn fa_arrow_right() -> Element {
  html.span(
    [
      attribute.class("fa-solid fa-arrow-right-long"),
      attribute.styles([css.inline_block]),
    ],
    [],
  )
}

pub fn div_padding(padding: Int) -> Element {
  html.div([attribute.class("p-" <> int.to_string(padding))], [])
}
