class GlobalConfig {
  // static const String baseUrl = 'https://freexyzdev.site';
  static const String baseUrl = 'http://192.168.100.131:3000';
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

  static Uri get postQuizUrl => Uri.parse('$baseUrl/quiz');
  static Uri get getQuizUrl => Uri.parse('$baseUrl/quiz');


  static Uri get postModuleUrl => Uri.parse('$baseUrl/module');
  static Uri get getModuleUrl => Uri.parse('$baseUrl/module');

  static Uri get postVidioUrl => Uri.parse('$baseUrl/videomaterial');
  static Uri get getVidioUrl => Uri.parse('$baseUrl/videomaterial');

  static Uri get postDiskusiUrl => Uri.parse('$baseUrl/discussion');
  static Uri get getDiskusiUrl => Uri.parse('$baseUrl/discussion');

  static Uri get postDiskusiReplyUrl => Uri.parse('$baseUrl/discussionreply');
  static Uri get getDiskusiReplyUrl => Uri.parse('$baseUrl/discussionreply');
}
