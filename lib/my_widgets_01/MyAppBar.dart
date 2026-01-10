import "package:flutter/material.dart";

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

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
        child: Text('Hello, Scaffold!'),
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