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
  var selectedGender = '';
  var acceptedTerms = false;

  List<String> countries = ['Vietnam', 'USA', 'Canada', 'UK', 'Australia'];
  List<String> genders = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Basics')),

      body: SingleChildScrollView(
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
                  FormField<String>(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gender is required';
                      }
                      return null;
                    },
                    initialValue: selectedGender,
                    builder: (FormFieldState<String> field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioGroup<String>(
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value ?? '';
                              });
                              field.didChange(value ?? '');
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: Text('Male'),
                                    value: 'Male',
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: Text('Female'),
                                    value: 'Female',
                                  ),
                                ),
                              ]
                            ),
                          ),
                          if (field.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                              child: Text(
                                field.errorText ?? '',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  
                  
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    title: Text('Accept terms and conditions'),
                    value: acceptedTerms,
                    onChanged: (value) {
                      setState(() {
                        acceptedTerms = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
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
        )
      ),
    );
  }
}
