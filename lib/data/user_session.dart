class UserSession {
  
  static String? loggedInEmail;
  static String? loggedInPassword;

  
  static void saveUser(String email, String password) {
    loggedInEmail = email;
    loggedInPassword = password;
    
    
    print("==============================");
    print("I/flutter: Submitting form");
    print("I/flutter: Form was validated");
    print("I/flutter: {email: $loggedInEmail}");
    print("I/flutter: {password: $loggedInPassword}");

    print("==============================");
  }

  
  static void clearSession() {
    loggedInEmail = null;
    loggedInPassword = null;
  }
}