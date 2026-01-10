import "package:flutter/material.dart";

class MyButton_3 extends StatelessWidget {
  const MyButton_3({super.key});

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
            color: Colors.white,
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
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                elevation: 5,
              ),
              child: const Text("click me"),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {print('InkWell tapped');},
              onDoubleTap: () {
                print('InkWell double tapped');
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'InkWell tap',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: null, child: const Text("Disabled Button")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){},
              onLongPress: () {
                print('Button long pressed');
              },
              onHover: (value) {
                print('Button hover: $value');
              },
              child: const Text("Disabled Button")
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
          activeIcon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          activeIcon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ]),
    );
  }
}