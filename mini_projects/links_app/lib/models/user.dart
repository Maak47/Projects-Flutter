// models/user.dart

class Member {
  final String username;
  final String email;
  final String password;

  Member({required this.username, required this.email, required this.password});
}

List<Member> dummyMembers = [
  Member(username: 'User1', email: 'user1@example.com', password: 'password1'),
  Member(username: 'User2', email: 'user2@example.com', password: 'password2'),
  Member(username: 'User3', email: 'user3@example.com', password: 'password3'),
];
