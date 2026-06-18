<div align="center">
  <img width="302" height="462" alt="chrome_sGoisSnbSQ" src="https://github.com/user-attachments/assets/4277564f-5bbd-4750-a225-27b66fa9245b" />
</div>

# An Artfight profile

[See what it looks like](https://artfight.net/~Knownser)

**Most** of the source code for my current Artfight profile.

## Why is it written in Gleam?

- It was just what I wanted to make it in.
- So I could write a cool semi-pointless parser
- I prefer it more than XML/HTML

## Little explainer

Inline styles are done via a little DSL called **Slass** (Literally just a portmanteau of Style-Class), it's pretty much just a `.ini` file with the ability to inject mustache `{{variables}}`. It only supports semi-colon prefixes for comments, this is purely to make it so you can use hex colour values in your styles without quotes.

Gleam-wise the slass getter function is passed around to each component, and the returned value is a lustre attribute.

---

#### Say you have a slass file like this:
```ini
; styles/main.slass.ini
[hi-im-a-class]
border = 2px solid {{some_color}}
color = white

[another-class]
background = blue
```

#### Then in gleam you'd do like:
```gleam
import gleam/dict
import slass

const file = "styles/main.slass.ini"

pub fn main() {
  let slass =
    slass.read(file, dict.from_list([#("some_color", "#FF00FF")]))
    |> slass.getter
  
  echo slass(["hi-im-a-class", "another-class"]) 

  //Attribute(
  //  kind: 0,
  //  name: "style",
  //  value: "border:2px solid #FF00FF;color: white;background: blue;"
  //)
}
```
