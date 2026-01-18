import 'package:app_new/userMS/db/repository/UserDatabaseHelper.dart';
import 'package:app_new/userMS/db/model/User.dart';
import 'package:app_new/userMS/ui/user/user_create_update/UserCreateUpdateScreen.dart';
import 'package:app_new/userMS/ui/user/user_detail/UserDetailScreen.dart';
import 'package:app_new/userMS/ui/user/user_list/UserListItem.dart';
import 'package:app_new/userMS/ui/user/user_list/MenuScreen.dart';
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
      drawer: MenuScreen(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          title: Text('User List'),
          backgroundColor: Colors.grey[700],
          foregroundColor: Colors.white,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _addUser
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _refreshUsers
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[700],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ]
            ),
            child: Divider(
              height: 10,
              thickness: 0,
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<User>>(
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
                      return UserListItem(user: user, onDelete: _deleteUser, onEdit: _editUser, onView: _viewUser);
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addUser();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _refreshUsers() {
    setState(() {
      _users = UserDatabaseHelper.instance.getUsers();
    });
  }

  void _addUser() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserCreateUpdateScreen(user: null, refreshUsers: _refreshUsers)));
  }

  void _deleteUser(User user) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Delete User'),
      content: Text('Are you sure you want to delete this user?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
        TextButton(onPressed: () {
          Navigator.pop(context);
          UserDatabaseHelper.instance.deleteUser(user.id!);
          setState(() {
            _users = UserDatabaseHelper.instance.getUsers();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${user.name} has been deleted'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 0
              ),
              duration: Duration(seconds: 2),
            )
          );
        }, child: Text('Delete')),
      ],
    ));
  }

  void _editUser(User user) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Edit User'),
      content: Text('Are you sure you want to edit this user?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
        TextButton(onPressed: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserCreateUpdateScreen(user: user, refreshUsers: _refreshUsers)));
        }, child: Text('Edit')),
        TextButton(onPressed: () {
          Navigator.pop(context);
          _viewUser(user);
        }, child: Text('View')),
      ],
    ));
  }

  void _viewUser(User user) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)));
  }
}
