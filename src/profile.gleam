import colors
import components
import css
import gleam/dict
import images
import lustre/attribute.{alt, class, styles}
import lustre/element
import lustre/element/html.{div, h2, img, p, text as t}
import simplifile
import slass.{type SlassGetter}
import util

type Element =
  element.Element(Nil)

fn bio_template(slass: slass.SlassGetter) -> Element {
  let h2 = h2([], _)
  let span = html.span([], _)
  let sup = html.sup([], _)

  element.fragment([
    h2([
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
        slass(["profile-dead-dog"]),
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
        "I only started drawing about two years ago,
         so expect my art quality to sometimes be inconsistent!",
      ),
      util.multi_br(count: 2),
      t("This year I'm planning on drawing "),
      util.bold("quite a decent amount,"),
      t(" but I also won't make any promises!"),
      util.multi_br(count: 2),

      span([
        t("Please feel free to have a peep below, I have a grand total of "),
        util.bold("two"),
        sup([t("(sorry)")]),
        t(" characters!"),
      ]),
    ]),
  ])
}

type TextContent {
  T(String)
  Slot(List(Element))
}

fn traits_template(slass: SlassGetter) -> Element {
  let header_style = slass(["trait-header", "nomargin"])

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

            components.interests_list(slass, [
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

fn ocs_list(slass: SlassGetter) -> Element {
  div(
    [
      class(
        "row mx-auto justify-content-center justify-content-sm-between pt-sm-5 pt-2 pl-2 pr-2 pb-2 p-sm-4 p-0",
      ),
      slass(["oc-list-root", "nomargin"]),
    ],
    [
      components.oc_card(
        slass,
        components.OC(
          name: "known",
          bouncer: "asddd.webp",
          bouncer_credits: "cheripuf",
          pfp: "https://images.artfight.net/character/yahFYpe5Eoa5c8JoI9UdWoXWOG2n8qoEUGgQZlf2Sqh9XofkUoGpfkzLfQkc.png",
          url: "https://artfight.net/character/6693652.known",
        ),
      ),
      components.oc_card(
        slass,
        components.OC(
          name: "vera",
          bouncer: "veralittle-missdoveyx.webp",
          bouncer_credits: "missdoveyx",
          pfp: "https://images.artfight.net/character/th_W0rU0sROmwatI3Yzy1QdJ1oMPWUSYJgfcyg7Lnpdvl5LGb24VkHPqU9zaL2G.png",
          url: "https://artfight.net/character/8628771.vera",
        ),
      ),
    ],
  )
}

fn profile_template(slass: SlassGetter) -> Element {
  element.fragment([
    components.header(slass),
    div(
      [
        slass(["profile-main"]),
      ],
      [
        div([class("container-lg"), slass(["profile-content"])], [
          html.br([]),
          bio_template(slass),
          html.hr([]),
          traits_template(slass),
          util.div_padding(3),
          ocs_list(slass),
          util.div_padding(1),
          components.friends_list(),
          components.breathing_mario(slass),
          util.div_padding(2),
        ]),
        div([slass(["profile-bottom-wave"])], []),
        components.footer(slass),
      ],
    ),
  ])
}

/// Call this via JavaScript ffi
pub fn render_profile() -> String {
  let output =
    slass.read("src/profile.slass.ini", dict.from_list(colors.dcss_vars))
    |> slass.getter
    |> profile_template
    |> element.to_string

  let _ = simplifile.create_file("out/generated.html")
  let _ = simplifile.write("out/generated.html", output)

  output
}
