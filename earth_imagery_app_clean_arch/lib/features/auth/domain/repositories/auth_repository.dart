import 'package:earth_imagery_app_clean_arch/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<bool> login(AuthEntity authEntity);
}
