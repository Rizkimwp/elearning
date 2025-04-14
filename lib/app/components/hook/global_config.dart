class GlobalConfig {
  static const String baseUrl = 'https://freexyzdev.site';

  // URL untuk login
  static Uri get loginUrl => Uri.parse('$baseUrl/auth/login');

  // URL untuk register
  static Uri get registerUrl => Uri.parse('$baseUrl/users/register');

  // URL untuk operasi meeting
  static Uri get postMeetingUrl => Uri.parse('$baseUrl/meeting');
  static Uri get getMeetingUrl => Uri.parse('$baseUrl/meeting');
  static Uri getMeetingByIdUrl(String id) => Uri.parse('$baseUrl/meeting/$id');
  static Uri putMeetingByIdUrl(String id) => Uri.parse('$baseUrl/meeting/$id');
  static Uri deleteMeetingByIdUrl(String id) =>
      Uri.parse('$baseUrl/meeting/$id');
}
