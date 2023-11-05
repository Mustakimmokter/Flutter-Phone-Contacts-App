class AppValidation {

  // Like This 1812598624 and 01812598624
  static bool isPhoneNumberValid(String phnNumber) {
    // ignore: unrelated_type_equality_checks
    String phoneValid = phnNumber[0]== '0'? r"(^([+]{1}[8]{2}|0088)?(01){1}[3-9]{1}\d{8})$" : r"(^([+][8]{2}|0088)?(01)|(1)[3-9]{1}\d{8})$";
    final bool regex = RegExp(phoneValid).hasMatch(phnNumber);
    return regex;
  }

}