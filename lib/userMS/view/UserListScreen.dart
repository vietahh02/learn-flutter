import 'package:app_new/userMS/db/UserDatabaseHelper.dart';
import 'package:app_new/userMS/model/User.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> _users;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    setState(() {
    _users = UserDatabaseHelper.instance.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshUsers
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteUser(user.id);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _refreshUsers() {
    setState(() {
      _users = UserDatabaseHelper.instance.getUsers();
    });
  }

  void _deleteUser(int? id) {
    UserDatabaseHelper.instance.deleteUser(id!);
    setState(() {
      _users = UserDatabaseHelper.instance.getUsers();
    });
  }
}
