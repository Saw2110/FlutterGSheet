mixin FormValidator {
  bool isPasswordValid(String password) => password.length == 6;

  bool isNotEmpty(String value) {
    return value.isNotEmpty;
  }

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp("$pattern");
    return regex.hasMatch(email);
  }

  bool isMobileNumberValid(String number) {
    Pattern pattern = "([9][678][0-6][0-9]{7})";
    RegExp regex = RegExp("$pattern");
    return regex.hasMatch(number);
  }
}
