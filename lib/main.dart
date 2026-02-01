// import 'package:app_new/my_widgets_01/MyButton_3.dart';
import 'package:app_new/userMS/ui/home/HomeScreen.dart';
// import 'package:app_new/userMS/ui/user/user_list/UserListScreen.dart';
// import 'package:app_new/my_widgets_02_form/f8_form_imagepicker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.grey[700],
        cardColor: Colors.grey,
        // dialogBackgroundColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
