import "package:flutter/material.dart";

class MyGestures extends StatelessWidget {
  const MyGestures({super.key});

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
            GestureDetector(
              onTap: () {
                print('Container tapped');
              },
              onLongPress: () {
                print('Container long-pressed');
              },
              onPanUpdate: (details) {
                print('Container panned details.delta: ${details.delta}');
              },
              child: Container(
                width: 200,
                height: 100,
                color: Colors.amber,
                child: Center(
                  child: Text(
                    'Tap Me',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
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