class GlobalConfig {
  static String baseUrl = 'https://freexyzdev.site';
  
  // Fungsi untuk mendapatkan URL login
  static Uri get loginUrl => Uri.parse('$baseUrl/auth/login');
  
  // Fungsi untuk mendapatkan URL register
  static Uri get registerUrl => Uri.parse('$baseUrl/users/register');
}
