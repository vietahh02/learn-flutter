import "package:flutter/material.dart";

class MyText extends StatelessWidget {
  const MyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20), //tao khoang cach giua cac widget
            const Text(
              'Hello, Flutter Welcome to my home u can do anything u want if u want but u can not do anything u dont want!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
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