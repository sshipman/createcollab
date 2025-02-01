import 'package:createcollab/pages/history_page.dart';
import 'package:createcollab/pages/home_page.dart';
import 'package:createcollab/pages/login_page.dart';
import 'package:createcollab/pages/my_profile_page.dart';
import 'package:createcollab/pages/new_request_page.dart';
import 'package:createcollab/pages/registration_page.dart';
import 'package:createcollab/pages/request_details_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ConnectMe',
        home: Login(),
        routes: {
          '/registration': (context) => const RegistrationPage(),
          '/home': (context) => const HomePage(),
          '/request_form': (context) => const NewRequestPage(),
          '/myprofile': (context) => const MyProfilePage(),
          '/history': (context) => const HistoryPage(),
          '/request': (context) => const RequestDetailsPage(),
        });
  }
}
