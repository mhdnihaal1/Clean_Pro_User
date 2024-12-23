import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalRepo {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

 static Future<void> storeToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

 Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

 static Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }

}

