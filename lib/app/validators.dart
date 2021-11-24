abstract class FieldValidator {
  bool isNotEmptyValidation(String str);
  bool isNotEmptyAndGraterThanZero(double number);
}

class NonEmptyValidator implements FieldValidator {
  @override
  bool isNotEmptyValidation(String value) {
    return value.isNotEmpty;
  }

  @override
  bool isNotEmptyAndGraterThanZero(double? number) {
    return (number != null && number > 0);
  }
}

class EmailAndPasswordValidator {
  final FieldValidator emailValidator = NonEmptyValidator();
  final FieldValidator passwordValidator = NonEmptyValidator();
  final String emailEmptyErrorValidator = 'Email Can\'t Be Empty';
  final String passwordEmptyErrorValidator = 'Password Can\'t Be Empty';
}

class JobAndRateValidator {
  final FieldValidator jobNameValidator = NonEmptyValidator();
  final FieldValidator jobRateValidator = NonEmptyValidator();
  final String jobNameEmptyErrorValidator =
      'The Job Name field can\'t By Empty';
  final String jobRateEmptyErrorValidator =
      'The Job Rate field can\'t By Empty';
}
