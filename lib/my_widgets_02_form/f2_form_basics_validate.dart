import "package:flutter/material.dart";

class FormBasicDemo2 extends StatefulWidget {
  const FormBasicDemo2({super.key});

  @override
  State<FormBasicDemo2> createState() => _FormBasicDemo2State();
}

class _FormBasicDemo2State extends State<FormBasicDemo2> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  var name = '';
  var email = '';
  var password = '';

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Basics')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [Form(
            key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.person), labelText: 'Name', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.email), labelText: 'Email', border: OutlineInputBorder()),
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
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.lock), labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: ElevatedButton(onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar( content: Text('Name: $name, Email: $email, Password: $password'), backgroundColor: Colors.green),
                        );
                      }
                    }, child: Text('Submit'))),
                    const SizedBox(width: 20),
                    Expanded(child: ElevatedButton(onPressed: (){}, child: Text('Reset'))),
                  ],
                ),
              ]
            ),
          )],
        ),
      ),
    );
  }
}
