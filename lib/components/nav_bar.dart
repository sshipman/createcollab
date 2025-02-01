import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  void Function(int)? onTap;

  NavBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'New Request')
      ],
      currentIndex: 0,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/myprofile');
            break;
          case 2:
            Navigator.pushNamed(context, '/history');
            break;
          case 3:
            Navigator.pushNamed(context, '/request_form');
            break;
          default:
            break;
        }
      },
    );
  }
}
