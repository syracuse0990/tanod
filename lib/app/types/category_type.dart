//Examples
enum CategoryType { trackor, user, name, dfa }

extension CategoryKeyword on CategoryType {
  String get keyword {
    switch (this) {
      case CategoryType.trackor:
        return "trackor";
      case CategoryType.user:
        return "trackor";
      case CategoryType.name:
        return "trackor";
      case CategoryType.dfa:
        return "trackor";
    }
  }
}
