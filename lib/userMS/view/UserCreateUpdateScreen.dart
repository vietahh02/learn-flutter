import 'package:app_new/userMS/db/UserDatabaseHelper.dart';
import 'package:app_new/userMS/model/User.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserCreateUpdateScreen extends StatefulWidget {
  final User? user;
  const UserCreateUpdateScreen({super.key, this.user});

  @override
  State<UserCreateUpdateScreen> createState() => _UserCreateUpdateScreenState();
}

class _UserCreateUpdateScreenState extends State<UserCreateUpdateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dateOfBirthController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.name ?? '');
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _phoneController = TextEditingController(text: widget.user?.phone ?? '');
    _dateOfBirthController = TextEditingController(
      text: widget.user?.dateOfBirth.toString() ?? ''
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user != null ? 'Update User' : 'Create User')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: Offset(0, 10))],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('User ${widget.user != null ? 'Update' : 'Create'}')),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name', 
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Colors.blue),
                    helperText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email, color: Colors.blue),
                    counter: Text('@example.com'),
                    counterStyle: TextStyle(color: Colors.blue, backgroundColor: Colors.red),
                    helperText: 'Enter your email',

                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Email must contain @';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone', border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone, color: Colors.blue),
                    helperText: 'Enter your phone',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _dateOfBirthController,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth', border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_month, color: Colors.blue),
                    suffixIcon: Icon(Icons.arrow_drop_down_outlined, color: Colors.blue),
                    helperText: 'Enter your date of birth',
                    counter: Text('dd/MM/yyyy'),
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Date of Birth is required';
                    }
                    return null;
                  },
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                      setState(() {
                        _dateOfBirthController.text = formattedDate;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    elevation: 5,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('Form is valid');
                      User user = User(
                        name: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        dateOfBirth: DateTime.parse(_dateOfBirthController.text),
                      );
                      UserDatabaseHelper.instance.insertUser(user).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User ${widget.user != null ? 'updated' : 'created'} successfully'), backgroundColor: Colors.green),
                        );
                        Navigator.pop(context);
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error ${widget.user != null ? 'updating' : 'creating'} user'), backgroundColor: Colors.red),
                        );
                      });
                    }
                  },
                  child: Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}