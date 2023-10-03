import 'package:flutter/material.dart';
import '../models/user.dart'; // Import the Member class and dummyMembers list

class MembersListScreen extends StatefulWidget {
  @override
  _MembersListScreenState createState() => _MembersListScreenState();
}

class _MembersListScreenState extends State<MembersListScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _addMember() {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return;
    }

    // Create a new member and add it to the dummyMembers list
    final newMember =
        Member(username: username, email: email, password: password);
    dummyMembers.add(newMember);

    // Clear input fields
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();

    // Close the modal bottom sheet
    Navigator.of(context).pop();

    // Show a success message
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text('Member added successfully.'),
      ),
    );
  }

  void _deleteMember(int index) {
    // Remove the member at the given index from the dummyMembers list
    if (index >= 0 && index < dummyMembers.length) {
      setState(() {
        dummyMembers.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Members List'),
      ),
      body: ListView.builder(
        itemCount: dummyMembers.length,
        itemBuilder: (context, index) {
          final member = dummyMembers[index];
          return MemberCard(
            member: member,
            onDelete: () {},
            index: index,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the modal bottom sheet for adding a new member
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Add New Member',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(labelText: 'Username'),
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _addMember,
                        child: Text('Add Member'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final Member member;
  final VoidCallback onDelete;
  final int index;

  MemberCard(
      {required this.member, required this.onDelete, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(member.username[0].toUpperCase()),
        ),
        title: Text(member.username),
        subtitle: Text(member.email),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete, // Call the onDelete callback when pressed
        ),
      ),
    );
  }
}
