import 'package:earth_imagery_app_clean_arch/features/auth/domain/entities/auth_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/auth_model.dart';

class AuthLocalDataSource {
  final Box<AuthModel> authBox;
  AuthLocalDataSource(this.authBox);

  Future<AuthModel?> getUserByUsername(String username) async {
    try {
      final storedUser =
          authBox.values.firstWhere((user) => user.username == username);
      return storedUser;
    } catch (e) {
      return null;
    }
  }

  Future<bool> login(AuthEntity authEntity) async {
    try {
      final storedUser = authBox.values
          .firstWhere((user) => user.username == authEntity.username);
      return storedUser.passwordHash == authEntity.password;
    } catch (e) {
      return false;
    }
  }
}
