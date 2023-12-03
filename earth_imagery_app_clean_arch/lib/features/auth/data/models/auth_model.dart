import 'package:earth_imagery_app_clean_arch/features/auth/domain/entities/auth_entity.dart';
import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 0)
class AuthModel {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String passwordHash;
  AuthModel({required this.username, required this.passwordHash});

  AuthEntity toEntity() =>
      AuthEntity(username: username, password: passwordHash);
}
