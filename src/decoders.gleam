import gleam/list
import gleam/dict.{type Dict}

pub type BuddyData {
  BuddyData(name: String, color: String, link: String)
}

pub fn parse_buddy_data(raw_ini: Dict(String, Dict(String, String))) {
  dict.to_list(raw_ini) 
  |> list.map(fn(v) {
    let #(name, inner_dict) = v
    let assert Ok(color) = dict.get(inner_dict, "color")

    let link = case dict.get(inner_dict, "link") {
      Ok(link) -> link
      _ -> "https://artfight.net/~" <> name
    }

    BuddyData(name, color, link)
  })
}