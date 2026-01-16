import 'package:app_new/userMS/model/User.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final Function(User) onDelete;
  final Function(User) onEdit;
  final Function(User) onView;    
  const UserListItem({super.key, required this.user, required this.onDelete, required this.onEdit, required this.onView});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {onView(user);},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue.shade100,
                    child: Text(user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade800),),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade800, overflow: TextOverflow.ellipsis,),),
                      Text(user.email, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, overflow: TextOverflow.ellipsis,),),
                    ], 
                  ),
                ]
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit), 
                    onPressed: () {onEdit(user);},
                    color: Colors.blue.shade600,
                    style: IconButton.styleFrom(backgroundColor: Colors.blue.shade100),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete), 
                    onPressed: () {onDelete(user);},
                    color: Colors.red.shade600,
                    style: IconButton.styleFrom(backgroundColor: Colors.red.shade100),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}