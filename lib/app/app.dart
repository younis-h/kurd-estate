import 'package:flutter/material.dart';

class KurdEstateApp extends StatelessWidget {
  const KurdEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kurd Estate',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF0E6B50),
        scaffoldBackgroundColor: Colors.white,
      ),

      home: const Scaffold(
        body: Center(
          child: Text(
            'Kurd Estate',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}