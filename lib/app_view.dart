import 'package:flutter/material.dart';

import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "springcrate",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade100,
          onBackground: Colors.black,
          primary: Color(0xFFFF6F00),
          secondary: Color(0xFF0090FF),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'Inter'),
          bodyText2: TextStyle(fontFamily: 'Inter'),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
