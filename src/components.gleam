//// For anything that is not a base html element wrapper

import gleam/list
import css
import lustre/attribute
import lustre/element
import lustre/element/html

type Element =
  element.Element(Nil)

pub fn credits(element: Element, username: String) -> Element {
  html.a(
    [attribute.title("by " <> username), attribute.href("#user_do_nothing")],
    [
      element,
    ],
  )
}

pub fn priority_root(with_margin: Bool, slot: List(Element)) -> Element {
  html.div(
    [
      attribute.class("d-flex align-items-start"),

      case with_margin {
        True -> attribute.styles([css.margin_bottom("0.9em")])
        _ -> attribute.none()
      },
    ],
    slot,
  )
}

pub fn priority_icon(color color: String, fa font_awesome: String) -> Element {
  html.div([
    attribute.styles([
      css.font_size("1.8em"),
      css.leading_none,
      css.color(color),
      css.margin_right("0.25em"),
      css.width("1.15em"),
      css.inline_block
    ])
  ], [
    html.span([
      attribute.class(font_awesome),
      attribute.styles([css.inline_block])
    ], [])
  ])
}

pub fn interests_list(interests: List(String)) -> Element {
  let unordered = fn(elements) { html.ul([], elements) }

  list.map(interests, fn(interest) {
    html.li([
      attribute.styles([
        css.font_size("1.08em"),
        css.margin_top("0.1em"),
        css.line_height("1.12")
      ])
    ], [html.text(interest)])
  })
  |> unordered
}