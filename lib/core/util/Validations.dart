class Validations {
  static String? usernameValidation(String? val) {
    if (val!.isEmpty) return 'Email Salah';
    return null;
  }

  static String? passwordValidation(String? val) {
    if (val!.isEmpty) return 'Password Salah';
    return null;
  }
}
