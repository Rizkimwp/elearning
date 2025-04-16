import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthHelper {
  static final box = GetStorage();

  static String? get token => box.read('jwt_token');

  static Map<String, dynamic>? get decodedToken {
    if (token == null) return null;

    try {
      return JwtDecoder.decode(token!);
    } catch (e) {
      return null;
    }
  }

  static String get userId => decodedToken?['sub'];        // ambil user ID
  static String get email => decodedToken?['email'];
  static String get role => decodedToken?['role'];
  static String get nama => decodedToken?['nama'];

  static bool get isLoggedIn => token != null && !JwtDecoder.isExpired(token!);
}
