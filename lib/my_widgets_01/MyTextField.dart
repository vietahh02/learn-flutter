import "package:flutter/material.dart";

class MyTextField extends StatelessWidget {
  const MyTextField({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar.new(
        title: Text('My Scaffold'),
        backgroundColor: Colors.blueGrey,
        leading: Icon(Icons.menu),
        elevation: 3,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {print('Search pressed');},
            
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {print('More pressed');},
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20), //tao khoang cach giua cac widget
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your name',
                hintText: 'Name',
              ),
            ),
            const SizedBox(height: 20), //tao khoang cach giua cac widget
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                labelText: 'Email',
                prefixIcon: Icon(Icons.email, color: Colors.blue),
                suffixIcon: Icon(Icons.check_circle, color: Colors.green),
                hintText: 'Email',
                helperText: 'Enter your email',
                errorText: 'Invalid email',
                fillColor: Color( 0xFFE0F7FA ),
                filled: true,
              ),
            ),
            const SizedBox(height: 20), //tao khoang cach giua cac widget
            TextField(
              obscureText: true,
              obscuringCharacter: '*',
              onChanged: (value) {},
              onSubmitted: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Password',
                errorText: 'Password is too short',
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {

                  },
                ),
              ),
            ),
            const SizedBox(height: 20), //tao khoang cach giua cac widget
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
                hintText: 'Phone Number',
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {},
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ]),
    );
  }
}