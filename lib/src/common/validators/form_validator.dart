class FormValidator {
  static String? notEmptyValidator(String? value) {
    if (value != null && value.isEmpty) {
      return "Can't be empty";
    }
  }

  static String? emailValidator(String? value) {
    if (value != null && !value.contains("@")) {
      return "Invalid email";
    }
  }
}
