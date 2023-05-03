class AppValidation {

  static bool isEmailValid(String email) {
    //final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    String emailValid2 = r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final bool regex = RegExp(emailValid2).hasMatch(email);
    return regex;
  }

}



abstract class ExampleOne {

  void methodOne(){
    print('mathodONe');
  }

  void methodTwo(){
    print('mathodTwo');
  }
}

class ExampleOverride implements ExampleOne {
  @override
  void methodOne() {
    // TODO: implement methodOne
  }

  @override
  void methodTwo() {
    // TODO: implement methodTwo
  }


}
