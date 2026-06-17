//// For anything that is not a base html element wrapper

import css
import gleam/dict.{type Dict}
import gleam/list
import ini
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
  html.div(
    [
      attribute.styles([
        css.font_size("1.8em"),
        css.leading_none,
        css.color(color),
        css.margin_right("0.25em"),
        css.width("1.15em"),
        css.inline_block,
      ]),
    ],
    [
      html.span(
        [attribute.class(font_awesome), attribute.styles([css.inline_block])],
        [],
      ),
    ],
  )
}

pub fn interests_list(interests: List(String)) -> Element {
  let unordered = fn(elements) { html.ul([], elements) }

  list.map(interests, fn(interest) {
    html.li(
      [
        attribute.styles([
          css.font_size("1.08em"),
          css.margin_top("0.1em"),
          css.line_height("1.12"),
        ]),
      ],
      [html.text(interest)],
    )
  })
  |> unordered
}

fn get_orelse(from: Dict(key, value), key: key, orelse: value) -> value {
  case dict.get(from, key) {
    Ok(val) -> val
    Error(_) -> orelse
  }
}

fn intersperse(list: List(t), seperator: t) -> List(t) {
  list.flat_map(list, fn(item) { [seperator, item] })
  |> list.drop(1)
}

pub fn friends_list() -> Element {
  let friend_list =
    ini.read("data/friends.conf")
    |> dict.to_list
    |> list.map(fn(value) {
      let #(friend, props) = value

      let link = get_orelse(props, "link", "https://artfight.net/~" <> friend)
      let color = get_orelse(props, "color", "#ffffff")

      html.a([attribute.href(link), attribute.style("color", color)], [
        html.text(friend),
      ])
    })
    |> intersperse(
      html.i([attribute.class("fa-solid fa-grip-dots-vertical ml-2 mr-2")], []),
    )

  let stars = fn() { html.i([attribute.class("fa-light fa-stars")], []) }

  html.div([attribute.class("text-center")], [
    html.h5([], [stars(), html.text(" Cool people! "), stars()]),

    html.div(
      [attribute.id("friends-list"), attribute.class("d-grid column-gap-3")],
      friend_list,
    ),
  ])
}
