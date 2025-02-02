import 'package:createcollab/components/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  void navigateBottomNavBar(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        onTap: (index) => navigateBottomNavBar(index),
      ),
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        //child: Text("Home Page"),
        child: OutlinedButton(
          onPressed: () async {
            final availableMaps = await MapLauncher.installedMaps;
            print(availableMaps);

            await availableMaps.first.showMarker(
              coords: Coords(37.759392, -122.5107336),
              title: "Ocean Beach",
            );
          },
          child: Text('Show on Map'),
      )),
    );
  }
}
