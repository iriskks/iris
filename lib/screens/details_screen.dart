import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String title;

  const DetailsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E2E2E),
        title: Text(title, style: const TextStyle(color: Colors.orangeAccent)),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF1B1B1B),
      body: Center(
        child: Text(
          'Здесь будет информация о категории "$title"',
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
