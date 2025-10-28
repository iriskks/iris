import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Предметы', 'icon': Icons.auto_awesome},
    {'title': 'Боссы', 'icon': Icons.warning},
    {'title': 'Персонажи', 'icon': Icons.person},
    {'title': 'Секреты', 'icon': Icons.lock},
    {'title': 'Комнаты', 'icon': Icons.door_front_door},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E2E2E),
        title: const Text(
          'Isaac Wiki',
          style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF2C2C2C),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(
                categories[index]['icon'],
                color: Colors.orangeAccent,
              ),
              title: Text(
                categories[index]['title'],
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                // Здесь можно добавить переход на экран категории
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Открыта категория: ${categories[index]['title']}',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          // Например, поиск или добавление статьи
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Функция в разработке')));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
