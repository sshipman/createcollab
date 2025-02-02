import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String _username = "username";
  String _fullName = "Full Name";
  String _bio = "This is the bio";
  String _contactNumber = "123-456-7890";
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Handle edit profile
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: _imagePath != null
                        ? ClipOval(
                            child: Image.network(
                              _imagePath!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          )
                        : Icon(Icons.person, size: 50),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle image upload
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                _username,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                _fullName,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                _bio,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                _contactNumber,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle complete profile
                },
                child: Text('Complete Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
