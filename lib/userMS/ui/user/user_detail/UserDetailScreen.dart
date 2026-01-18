import 'package:app_new/userMS/db/model/User.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Detail')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade100,
                child: Text(user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade800),),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // boxShadow: [
              //   BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: Offset(0, 10)),
              // ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey.shade800,),  ),
                Text(user.email, style: TextStyle(fontSize: 16, color: Colors.grey.shade600,),),
                Text(user.phone, style: TextStyle(fontSize: 16, color: Colors.blue.shade600,),),
                Text(user.dateOfBirth.toString(), style: TextStyle(fontSize: 16, color: Colors.purple.shade600,),),
              ],
            ),
          ),
        ],
      ),
    );
    }
  }
