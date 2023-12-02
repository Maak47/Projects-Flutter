// auth_repository_impl.dart
import 'package:earth_imagery_app_clean_arch/features/auth/data/datasources/local_datasources/auth_local_datasource.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/domain/entities/auth_entity.dart';
import 'package:earth_imagery_app_clean_arch/features/auth/domain/usecases/login_usecase.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;
  final LoginUsecase loginUsecase;

  AuthRepositoryImpl(
      {required this.authLocalDataSource, required this.loginUsecase});

  @override
  Future<bool> login(AuthEntity authEntity) async {
    try {
      final storedUser =
          await authLocalDataSource.getUserByUsername(authEntity.username);
      if (storedUser != null) {
        return loginUsecase.login(authEntity, storedUser.passwordHash);
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
