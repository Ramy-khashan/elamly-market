   String getMessageFromErrorCode(String errorCode) {
    print(errorCode);
    switch (errorCode.toUpperCase()) {
      case "ACCOUNT-EXSISTS-WITH-DIFFERENT-CREDENTIAL":
        return "Email already used. Go to login page.";

      case "EMAIL-ALREADY-IN-USE":
        return "Email already used. Go to login page.";

      case "ERROR_WRONG_PASSWORD":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
        return "Email address is invalid.";

      case "USER_NOT_FOUND":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many requests to log into this account.";

      case "OPERATION-NOT-ALLOED":
        return "Too many requests to log into this account.";

      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Server error, please try again later.";

      case "ERROR_INVALID_EMAIL":
        return "Email address is invalid.";

      case "INVALID_EMAIL":
        return "Email address is invalid.";
      default:
        return "Login failed. Please try again.";
    }
  }

