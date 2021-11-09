abstract class StringValidator {
  bool isNotEmptyValidation(String str);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isNotEmptyValidation(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidator {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String emailEmptyErrorValidator = 'Email Can\'t Be Empty';
  final String passwordEmptyErrorValidator = 'Password Can\'t Be Empty';
}
