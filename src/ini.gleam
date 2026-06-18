import gleam/dict.{type Dict}
import gleam/list
import gleam/string
import simplifile

type Token {
  Section(String)
  Key(String)
  Unknown
  Comment
}

type Parsed =
  Dict(String, Dict(String, String))

fn determine_section_token(chunk: String) -> Result(Token, Token) {
  case string.ends_with(chunk, "]") {
    True -> Ok(Section(string.remove_suffix(chunk, "]")))
    False -> Error(Unknown)
  }
}

fn tokenizer(lines: List(String)) -> List(Token) {
  use line <- list.filter_map(lines)
  let trimmed = string.trim(line)

  case trimmed {
    "[" <> sub -> determine_section_token(sub)
    ";" <> _ -> Error(Comment)
    _ -> Ok(Key(trimmed))
  }
}

fn strip_quotes(text: String) -> String {
  text
  |> string.remove_prefix("\"")
  |> string.remove_suffix("\"")
}

fn resolve_mustache(value: String, variables: Dict(String, String)) -> String {
  dict.fold(variables, from: value, with: fn(acc, key, replacement) {
    let pattern = "{{" <> key <> "}}"
    string.replace(acc, each: pattern, with: replacement)
  })
}

fn parser(lines: List(String)) -> Parsed {
  let tokens = tokenizer(lines)
  let start_state = #("", dict.new())

  let #(_, parsed) =
    list.fold(tokens, start_state, fn(state, token) {
      let #(current_section, sections) = state

      case token {
        Section(name) -> {
          #(string.trim(name), sections)
        }

        Key(key_line) -> {
          case string.split_once(key_line, on: "=") {
            Ok(#(k, v)) -> {
              let clean_key = string.trim(k)
              let clean_val =
                string.trim(v)
                |> strip_quotes

              let section_dict = case dict.get(sections, current_section) {
                Ok(existing) -> dict.insert(existing, clean_key, clean_val)
                Error(_) -> dict.from_list([#(clean_key, clean_val)])
              }

              let updated_sections =
                dict.insert(sections, current_section, section_dict)
              #(current_section, updated_sections)
            }
            Error(_) -> state
          }
        }

        _ -> state
      }
    })

  parsed
}

pub fn read(path: String, variables: Dict(String, String)) -> Parsed {
  let assert Ok(content) = simplifile.read(from: path)
  let lines =
    resolve_mustache(content, variables)
    |> string.split(on: "\n")

  parser(lines)
}
