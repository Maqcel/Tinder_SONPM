enum Gender {
  woman,
  man,
}

extension ToString on Gender {
  String toValueString() {
    return toString().split('.').last;
  }
}
