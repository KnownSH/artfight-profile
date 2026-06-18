import lustre/attribute.{type Attribute, src}

pub fn derg_cdn(name: String) -> Attribute(message) {
  src("https://cdn.derg.space/assets/af/" <> name)
}
