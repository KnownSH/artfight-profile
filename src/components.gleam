//// For anything that is not a base html element wrapper

import lustre/element.{type Element}
import lustre/element/html
import lustre/attribute

pub fn credits(element: Element(Nil), username: String) -> Element(Nil) {
  html.a([attribute.title("by " <> username), attribute.href("#user_do_nothing")], [
    element,
  ])
}