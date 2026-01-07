import "package:flutter/material.dart";

class FormDropdownDemo extends StatefulWidget {
  const FormDropdownDemo({super.key});

  @override
  State<FormDropdownDemo> createState() => _FormDropdownDemoState();
}

class _FormDropdownDemoState extends State<FormDropdownDemo> {
  final _formKey = GlobalKey<FormState>();
  var name = '';
  var email = '';
  var password = '';
  var selectedCountry = '';

  List<String> countries = ['Vietnam', 'USA', 'Canada', 'UK', 'Australia'];

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
                  decoration: InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
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
                  decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
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
                  decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
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
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Country', border: OutlineInputBorder()),
                  items: countries.map((country) => DropdownMenuItem(value: country, child: Text(country))).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value ?? '';
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
