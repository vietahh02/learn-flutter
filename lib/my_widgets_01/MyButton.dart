import "package:flutter/material.dart";

class MyButton extends StatelessWidget {
  const MyButton({super.key});

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
      
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20), //tao khoang cach giua cac widget
            ElevatedButton(onPressed: (){}, child: const Text("click me")),
            const SizedBox(height: 20),
            OutlinedButton(onPressed: (){}, child: const Text("click me too")),
            const SizedBox(height: 20),
            TextButton(onPressed: (){}, child: const Text("and me")),
            const SizedBox(height: 20),
            IconButton(onPressed: (){}, icon: Container(
              color: Colors.amber,
              child: const Icon(Icons.volume_up, size: 30),
            )),
            const SizedBox(height: 20),
            FloatingActionButton(onPressed: (){}, child: const Icon(Icons.add)),
            const SizedBox(height: 20),
            ElevatedButton.icon(onPressed: (){}, icon: const Icon(Icons.add), label: const Text("click me")),
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