class Validator {
// Function to validate password
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is required.";
    } else if (value.length < 7) {
      return "Password should atleast be of 7 characters.";
    }
    return null;
  }

// Function to validate name.
  String? validateName(String value) {
    if (value.isEmpty) {
      return "Please enter your full name.";
    }
    return null;
  }

// Function to validate name.
  String? validateDob(String value) {
    if (value.isEmpty) {
      return "Please enter your date of birth.";
    }
    return null;
  }

// Function to validate email
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter your email.";
    }

    const emailPattern =
        r'[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // Email validation regular expression
    final regEx = RegExp(emailPattern);

    if (!regEx.hasMatch(value)) {
      return "Enter a valid email ID.";
    }
    return null;
  }

// Function to validate phone number
  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return "Please enter your number.";
    }
    String numPattern =
        r'^[0-9]+$'; //Phone Number validation regular expression.
    RegExp regExp = new RegExp(numPattern);

    if (!regExp.hasMatch(value)) {
      return "Invalid number format.";
    } else if (value.length < 10 || value.length > 10) {
      return "Number should be of 10 digits.";
    }
    return null;
  }
}
