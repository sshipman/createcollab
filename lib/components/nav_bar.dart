import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  void Function(int)? onTap;

  NavBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        print(index);
        Navigator.pushNamed(
            context,
            '/${index == 0 ? 'home' : index == 1 ? 'myprofile' : 'history'}');
      },
    );
  }
}
