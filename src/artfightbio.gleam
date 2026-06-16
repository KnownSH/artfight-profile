import util.{derg_cdn}
import css
import lustre/attribute.{alt, class, src, style, styles}
import lustre/element.{type Element}
import lustre/element/html.{a, div, h2, img, p, text}

const ctp_mauve = "#cba6f7"

const ctp_base = "#1e1e2e"

fn credits(element: Element(Nil), username: String) -> Element(Nil) {
  a([attribute.title("by " <> username), attribute.href("#user_do_nothing")], [
    element,
  ])
}

fn bio_template() -> Element(Nil) {
  element.fragment([
    h2([], [
      text("Hey! I'm "),
      img([
        styles([css.vertical_align("top")]),
        src(derg_cdn("known-neon-logo-animated.webp")),
        alt("Known"),
        attribute.height(37),
      ]),
      text("!"),
    ]),

    p([style("font-size", "1rem")], [
      img([
        styles([
          #("float", "right"),
          #("margin-bottom", "-20px"),
          #("margin-top", "-30px"),
        ]),
        attribute.height(150),
        attribute.width(150),
        src(derg_cdn("doveyknownwomp.webp")),
        alt("derg womp"),
      ]) 
      |> credits("missdoveyx"),
    ])
  ])
}

fn profile_template(_) -> Element(Nil) {
  div(
    [
      class("container-sm"),
      styles([
        css.border_int(4, css.Outset, ctp_mauve),
        css.background(ctp_base),
        css.min_height("200px"),
        css.max_width("700px"),
        css.padding("15px 15px 0"),
      ]),
    ],
    [
      html.br([]),

      bio_template(),
    ],
  )
}

pub fn render_profile(name: String) -> String {
  profile_template(name)
  |> element.to_string
}
