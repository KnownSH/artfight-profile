import colors
import components
import css
import gleam/dict.{type Dict}
import images
import ini
import lustre/attribute.{alt, class, styles}
import lustre/element
import lustre/element/html.{div, h2, img, p, text as t}
import util

type Element =
  element.Element(Nil)

type Style =
  Dict(String, String)

pub type Slass =
  fn(String) -> attribute.Attribute(Nil)

fn slass_core(class: String, style: Style) -> attribute.Attribute(message) {
  let assert Ok(val) = dict.get(style, class)
  attribute.attribute("style", val)
}

fn bio_template() -> Element {
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
          css.margin_bottom("-20px"),
          css.margin_top("-30px"),
        ]),
        attribute.height(150),
        attribute.width(150),
        images.derg_cdn("doveyknownwomp.webp"),
        alt("derg womp"),
      ])
        |> components.credits("missdoveyx"),

      t("My main oc is also called "),
      util.bold("Known"),
      t(", but my username online is usually"),
      util.bold_italic(util.quotes("Knownser")),
      t(" or "),
      util.bold_italic(util.quotes("KnownSH") <> "."),

      t(
        "I decided to start drawing about two years ago, so expect my art quality to sometimes be inconsistent!",
      ),
      util.multi_br(count: 2),
      t("This year I'm planning on drawing "),
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

type TextContent {
  T(String)
  Slot(List(Element))
}

fn traits_template() -> Element {
  let header_style =
    styles([
      css.margin("0"),
      css.line_height("1.05"),
      css.font_size("1.17em"),
      css.font_weight(700),
    ])

  let text_content = fn(header: String, text: TextContent) {
    let paragraph = case text {
      T(text) -> [t(text)]
      Slot(slot) -> slot
    }

    div([class("flex-grow-1"), styles([css.min_width("0")])], [
      div(
        [
          header_style,
        ],
        [t(header)],
      ),

      div(
        [
          styles([
            css.margin("0.24em 0 0"),
            css.line_height("1.12"),
            css.font_size("1.08em"),
          ]),
        ],
        paragraph,
      ),
    ])
  }

  div([class("row align-items-start")], [
    // priorities
    div(
      [
        class("col-12 col-sm-8 d-flex flex-column"),
        styles([css.padding_left("20px")]),
      ],
      [
        components.priority_root(True, [
          components.priority_icon("#fab387", "fa-fw fa-solid fa-star"),
          text_content(
            "Priority",
            Slot([
              t(" Mutuals "),
              util.fa_arrow_right(),
              t(" Interests "),
              util.fa_arrow_right(),
              t(" Revenge "),
            ]),
          ),
        ]),

        components.priority_root(True, [
          components.priority_icon(
            "#a6e3a1",
            "fa-fw fa-duotone fa-solid fa-check",
          ),
          text_content("Will draw", T("Furries, humans (friends only)")),
        ]),

        components.priority_root(False, [
          components.priority_icon("#f38ba8", "fa-fw fa-solid fa-ban"),
          text_content(
            "Won't Draw",
            T("NSFW, gore, highly suggestive, complex anatomy"),
          ),
        ]),
      ],
    ),

    div(
      [
        class("col-12 col-sm-4 mt-3 mt-sm-0 pl-4 pl-sm-0"),
        styles([
          css.padding_top("0.5em"),
          css.padding_bottom("0.5em"),
          css.border_left_int(2, css.Solid, colors.ctp_mauve),
          css.background(colors.ctp_mantle),
        ]),
      ],
      [
        div(
          [
            class("text-left text-sm-right pt-3"),
            styles([css.line_height("1.12")]),
          ],
          [
            div([header_style], [t("My interests!")]),

            components.interests_list([
              "Spaceflight",
              "Dergs",
              "3D Modelling",
              "Computing",
              "Fancy outfits",
            ]),
          ],
        ),
      ],
    ),
  ])
}

fn profile_template(slass: Slass) -> Element {
  div(
    [
      class("container-sm"),
      slass("profile-main"),
    ],
    [
      html.br([]),
      bio_template(),
      html.hr([]),
      traits_template(),
      util.div_padding(3),
      // todo here
      util.div_padding(1),
      html.hr([attribute.width(200)]),
      components.friends_list(),
    ],
  )
}

/// Call this via JavaScript ffi
pub fn render_profile() -> String {
  let style =
    ini.read("src/profile.slass", dict.from_list(colors.dcss_vars))
    |> dict.fold(from: dict.new(), with: fn(acc, key, value) {
      let computed_style =
        dict.fold(value, "", fn(style, prop, style_value) {
          style <> prop <> ":" <> style_value <> ";"
        })
      dict.insert(acc, key, computed_style)
    })

  let slass = fn(class) { slass_core(class, style) }

  profile_template(slass)
  |> element.to_string
}
