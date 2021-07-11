class ValidateInput {
  static String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  static String validateComment(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Comment is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Comment must be a-z and A-Z";
    }
    return null;
  }

  static String validateSabhaName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  static String validatePassword(String value) {
    String pattern = r'^[a-zA-Z]\w{5,15}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Password is Required";
    } else if (value.length != 0 && value.length <= 5) {
      return "Password contains minimum 6 characters";
    } else if (!regExp.hasMatch(value)) {
      return null;
    }
    return null;
  }

  static String validateOtp(String value) {
    if (value.length == 0) {
      return "OTP is Required";
    }
    return null;
  }

  static String validateSignupPassword(String value) {
    // Pattern pattern = r'^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    String pattern = r'^[a-zA-Z]\w{5,15}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    } else if (value.length != 0 && value.length <= 7) {
      return "Password contains minimum 8 characters";
    } else if (!regex.hasMatch(value)) {
      return null;
    }
  }

  static String validatePasswordSpecial(String value) {
    Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value))
        return 'Password must be 8 characters,numbers & special characters';
      else
        return null;
    }
  }

  static String validateMobile(String value) {
    if (value.length < 10) {
      return 'Enter Valid Mobile Number';
    }
    return null;
  }

  static String validatePin(String value) {
    if (value.length < 6) {
      // return MyStrings.pinLessThanSix;
    }
    return null;
  }

  static String validatePinCode(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Postcode is Required";
    } else if (value.length != 6) {
      return "Postcode must 6 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Postcode must be digits";
    }
    return null;
  }

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  static String verifyFields(valueOne, String valueTwo) {
    if (valueOne.contains(valueTwo))
      return null;
    else
      return 'Not matching';
  }

  static String requiredFields(String value) {
    if (value.isNotEmpty)
      return null;
    else
      return 'Required';
  }
}
