class UserSession {
  // Variabel statis untuk menyimpan data user yang sedang aktif
  static String? loggedInEmail;
  static String? loggedInPassword;

  // Fungsi untuk menyimpan data saat login berhasil
  static void saveUser(String email, String password) {
    loggedInEmail = email;
    loggedInPassword = password;
    
    // Ini agar muncul di Debug Console VS Code kamu
    print("==============================");
    print("I/flutter: Submitting form");
    print("I/flutter: Form was validated");
    print("I/flutter: {email: $loggedInEmail}");
    print("I/flutter: {password: $loggedInPassword}");

    print("==============================");
  }

  // Fungsi untuk menghapus data saat logout
  static void clearSession() {
    loggedInEmail = null;
    loggedInPassword = null;
  }
}