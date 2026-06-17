//// For anything that is not a base html element wrapper

import images
import slass
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

pub type OC {
  OC(
    name: String,
    bouncer: String,
    bouncer_credits: String,
    pfp: String,
    url: String,
  )
}

pub fn oc_card(slass: slass.SlassGetter, oc: OC) -> Element {
  html.div([
    attribute.class("col-8 px-0 col-sm-5 mb-3 mb-sm-0 mx-auto mx-sm-0")
  ], [
    html.div([slass(["oc-bouncer"])], [
      html.img([
        images.derg_cdn(oc.bouncer),
        attribute.class("fa-bounce"),
        slass(["oc-bouncer-" <> oc.name])
      ])
      |> credits(oc.bouncer_credits)
    ]),

    html.a([
      attribute.href(oc.url),
      attribute.title(oc.name)
    ], [
      html.img([
        attribute.class("d-block w-100"),
        slass(["oc-card"]),
        attribute.src(oc.pfp),
        attribute.alt(oc.name)
      ]),
      html.div([
        attribute.class("pt-1 pt-sm-2 text-center"),
        attribute.style("color", "#cdd6f4")
      ], [
        html.img([
          images.derg_cdn(oc.name <> "-sm-neon-logo-animated.webp"),
          attribute.alt("animated text displaying " <> oc.name)
        ])
      ])
    ])
  ])
}

fn get_orelse(from: Dict(key, value), key: key, orelse: value) -> value {
  case dict.get(from, key) {
    Ok(val) -> val
    Error(_) -> orelse
  }
}

pub fn friends_list() -> Element {
  let friend_list =
    ini.read("data/friends.conf", dict.new())
    |> dict.to_list
    |> list.map(fn(value) {
      let #(friend, props) = value

      let link = get_orelse(props, "link", "https://artfight.net/~" <> friend)
      let color = get_orelse(props, "color", "#ffffff")

      html.a([attribute.href(link), attribute.style("color", color)], [
        html.text(friend),
      ])
    })
    |> list.intersperse(
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

pub fn breathing_mario(slass: slass.SlassGetter) -> Element {
  html.div([
    attribute.class("d-flex flex-row"),
    slass(["breathing-mario"])
  ], [
    html.div([attribute.class("p-2"), attribute.style("width", "90%")], []),
    html.img([
      attribute.class("fa-beat-fade"),
      attribute.width(40),
      images.derg_cdn("breathing-mario.webp"),
      attribute.alt("breathing buddy")
    ]),
    html.div([attribute.style("font-size", "0.2em")], [
      html.text("1.. 2.. 3.. lets see what happens.")
    ]),
  ])
}

pub fn header(slass: slass.SlassGetter) -> Element {
  html.div([
    attribute.class("d-flex justify-content-start"),
    slass(["header"])
  ], [
    html.div([
      slass(["header-fake-button"]),
      attribute.class("text-center pl-3 pr-3")
    ], [
      html.div([attribute.class("d-flex align-items-center")], [
        html.i([attribute.class("fa-regular fa-file-code pr-2")], []),
        html.text("pages/knownser.gleam")
      ])
    ]),
    html.div([
      slass(["header-rest"]),
      attribute.class("text-center w-100")
    ], []),
    html.div([
      slass(["header-fake-button"]),
      attribute.class("text-center pl-2 pr-2")
    ], [html.text("x")]),
  ])
}

pub fn footer(slass: slass.SlassGetter) -> Element {
  html.div([
    attribute.class("d-flex justify-content-between pr-2"),
    slass(["footer", "bg-mauve"])
  ], [
    html.img([
      attribute.src("https://cdn.derg.space/counter/knownser.png"),
      attribute.alt("Visitor counter"),
      slass(["footer-vistor-counter"]),
    ]),
    html.a([
      attribute.href("https://github.com/KnownSH/artfight-profile"),
      attribute.class("w-100 pl-3"),
      slass(["footer-source-align"])
    ], [
      html.div(
        [slass(["footer-source-url-i"])],
        [html.i([attribute.class("fa-sharp-duotone fa-solid fa-code")], [])]
      )
    ]),
  ])
}