enum Passions {
  fashion,
  shopping,
  volleyball,
  basketball,
  tea,
  wine,
  music,
  books,
  cosmetics,
  movies,
  swimming,
  cooking,
}

extension ToString on Passions {
  String toValueString() {
    return toString().split('.').last;
  }
}
