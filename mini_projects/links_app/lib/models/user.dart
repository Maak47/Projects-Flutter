// models/user.dart

class Member {
  final String username;
  final String email;
  final String password;

  Member({required this.username, required this.email, required this.password});
}

List<Member> dummyMembers = [
  Member(username: 'User1', email: 'user1@example.com', password: 'password1'),
];
