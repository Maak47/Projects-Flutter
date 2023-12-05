import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String passwordHash;

  UserModel({required this.username, required this.passwordHash});
  String toString() {
    return 'UserModel(username: $username, password: $passwordHash)';
  }
}
