import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/domain/entities/auth_entity.dart';

class LoginUsecase {
  bool login(AuthEntity authEntity, String storedPasswordHash) {
    String hashedPassword = _hashPassword(storedPasswordHash);
    return hashedPassword == storedPasswordHash;
  }

  String _hashPassword(String password) {
    final salt = _generateSalt();
    final hash = _hashWithSalt(password, salt);
    return '$hash:$salt';
  }

  String _hashWithSalt(String password, String salt) {
    final Uint8List passwordBytes = Uint8List.fromList(utf8.encode(password));
    final Uint8List saltBytes = Uint8List.fromList(utf8.encode(salt));
    final Uint8List combined =
        Uint8List(passwordBytes.length + saltBytes.length)
          ..setAll(0, passwordBytes)
          ..setAll(passwordBytes.length, saltBytes);

    final List<int> hashBytes = sha512.convert(combined).bytes;
    return base64.encode(hashBytes);
  }

  String _generateSalt() {
    final Uint8List saltBytes = Uint8List(32); // You can adjust the salt length
    final Random random = Random.secure();
    for (int i = 0; i < saltBytes.length; i++) {
      saltBytes[i] = random.nextInt(256);
    }
    return base64.encode(saltBytes);
  }
}
