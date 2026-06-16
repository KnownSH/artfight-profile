import lustre/attribute.{src, type Attribute}

pub fn derg_cdn(name: String) -> Attribute(message) {
  src("https://cdn.derg.space/assets/af/" <> name)
}