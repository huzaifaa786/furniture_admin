class Validators {
  Validators._();

  /// Validates if the given string is empty
  static String? emptyStringValidator(
    String? value,
    String valueType,
  ) {
    if (value == null) {
      return null;
    } else if (value.isEmpty) {
      return "$valueType can't be empty";
    } else {
      return null;
    }
  }

  /// Validates the Email for User Authentication
  static String? emailValidator(String? email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    if (email == null) {
      return null;
    } else if (email.isEmpty) {
      return "Email can't be empty";
    } else if (!emailRegExp.hasMatch(email)) {
      return "Invalid Email Address";
    } else {
      return null;
    }
  }

  /// Validates the Password for User Authentication
  static String? passwordValidator(String? password) {
    // ignore: unnecessary_raw_strings
    // final digitRegExp =
    //     RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{1,}$');
    if (password!.length < 6) {
      return "*Password must be 6 characters long";
    } else {
      return null;
    }

    // if (password == null) {
    //   return null;
    // } else if (password.isEmpty) {
    //   return "Password can't be empty";
    // } else if (!digitRegExp.hasMatch(password)) {
    //   return "Password must contain numbers and special character";
    // } else if (password.length < 8) {
    //   return "Password must be 8 characters long";
    // } else {
    //   return null;
    // }
  }

static String? confirmPasswordValidator(String? password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return "Confirm password can't be empty";
  } else if (password != confirmPassword) {
    return "Passwords do not match";
  } else {
    return null;
  }
}

  /// Validates the Date Of Birth for Account Creation
  static String? dobValidator({
    required String? dob,
    required int age,
  }) {
    if (dob == null) {
      return null;
    } else if (dob.isEmpty) {
      return "Date can't be empty";
    } else if (age <= 16) {
      return "You must be over 16 to create a seller account";
    } else {
      return null;
    }
  }

  static String? userNameValidator({
    required String? username,
    required bool alreadyExists,
  }) {
    if (username == null) {
      return null;
    } else if (username.isEmpty) {
      return "Username can't be empty";
    } else if (alreadyExists) {
      return "Username already exists";
    } else {
      return null;
    }
  }
}
