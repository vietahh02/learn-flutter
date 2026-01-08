import 'dart:io';

import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class FormDropdownDemo extends StatefulWidget {
  const FormDropdownDemo({super.key});

  @override
  State<FormDropdownDemo> createState() => _FormDropdownDemoState();
}

class _FormDropdownDemoState extends State<FormDropdownDemo> {
  final _formKey = GlobalKey<FormState>();
  final _dateOfBirthController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  File? _imageFile;
  var name = '';
  var email = '';
  var password = '';
  var selectedCountry = '';
  var selectedGender = '';
  var dateOfBirth = '';
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
                  TextFormField(
                    controller: _dateOfBirthController,
                    decoration: InputDecoration(labelText: 'Date of birth', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Date of birth is required';
                      }
                      return null;
                    },
                    readOnly: true,
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
                      // showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now()).then((value) {
                      //   if (value != null) {
                      //     setState(() {
                      //       _dateOfBirthController.text = value.toString();
                      //     });
                      //   }
                      // });
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
                  const SizedBox(height: 20),
                  FormField<File>(
                    validator: (value) {
                      if (value == null) {
                        return 'Image is required';
                      }
                      return null;
                    },
                    initialValue: _imageFile,
                    builder: (FormFieldState<File> field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                final ImageSource? source = await showDialog<ImageSource>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Select Image'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: Icon(Icons.camera_alt),
                                            title: Text('Camera'),
                                            onTap: () => Navigator.pop(context, ImageSource.camera),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.photo_library),
                                            title: Text('Gallery'),
                                            onTap: () => Navigator.pop(context, ImageSource.gallery),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                if (source != null) {
                                  final XFile? image = await _imagePicker.pickImage(source: source);
                                  if (image != null) {
                                    setState(() {
                                      _imageFile = File(image.path);
                                    });
                                    field.didChange(_imageFile);
                                  }
                                }
                              },
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: _imageFile != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          _imageFile!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
                                          SizedBox(height: 10),
                                          Text('Tap to select image', style: TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                              ),
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
