import colors
import css
import images
import lustre/attribute.{alt, class, styles}
import lustre/element.{type Element}
import lustre/element/html.{a, div, h2, img, p}
import util

// Text is used soo much
const t = html.text

fn credits(element: Element(Nil), username: String) -> Element(Nil) {
  a([attribute.title("by " <> username), attribute.href("#user_do_nothing")], [
    element,
  ])
}

fn bio_template() -> Element(Nil) {
  element.fragment([
    h2([], [
      t("Hey! I'm "),
      img([
        styles([css.vertical_align("top")]),
        images.derg_cdn("known-neon-logo-animated.webp"),
        alt("Known"),
        attribute.height(37),
      ]),
      t("!"),
    ]),

    p([styles([css.text_base])], [
      img([
        styles([
          css.float_right,
          #("margin-bottom", "-20px"),
          #("margin-top", "-30px"),
        ]),
        attribute.height(150),
        attribute.width(150),
        images.derg_cdn("doveyknownwomp.webp"),
        alt("derg womp"),
      ])
        |> credits("missdoveyx"),

      t("My main oc is also called "),
      util.bold("Known"),
      t(", by my username online is usually"),
      util.quotes("Knownser") |> util.bold_italic,
      t(" or "),
      { util.quotes("KnownSH") <> "." } |> util.bold_italic,

      t(
        "I decided to start drawing about two years ago, so expect my art quality to sometimes be inconsistent!",
      ),
      util.multi_br(count: 2),
      t("This year im planning on drawing "),
      util.bold("quite a decent amount,"),
      t(" but I also won't make any promises!"),
      util.multi_br(count: 2),

      html.span([], [
        t("Please feel free to have a peep below, I have a grand total of "),
        util.bold("two"),
        html.sup([], [t("(sorry)")]),
        t(" characters!"),
      ]),
    ]),
  ])
}

fn profile_template() -> Element(Nil) {
  div(
    [
      class("container-sm"),
      styles([
        css.border_int(4, css.Outset, colors.ctp_mauve),
        css.background(colors.ctp_base),
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

pub fn render_profile() -> String {
  profile_template()
  |> element.to_string
}
