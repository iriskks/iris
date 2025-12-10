import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'details_screen.dart';

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

  String? lastOpened;
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadLastOpened();
    _loadUser();
  }

  Future<void> _loadLastOpened() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lastOpened = prefs.getString('lastOpened');
    });
  }

  Future<void> _saveLastOpened(String title) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastOpened', title);
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
      userEmail = prefs.getString('userEmail');
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    await prefs.remove('userEmail');
    if (mounted) {
      setState(() {
        userName = null;
        userEmail = null;
      });
    }
  }

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
        actions: [
          if (userName == null)
            IconButton(
              icon: const Icon(Icons.login, color: Colors.orangeAccent),
              onPressed: () async {
                // Переходим на LoginScreen и ждём результат
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
                await _loadUser(); // обновляем данные пользователя
              },
            )
          else
            PopupMenuButton<int>(
              icon: const Icon(Icons.person, color: Colors.orangeAccent),
              color: const Color(0xFF2E2E2E),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    "Вы: $userName",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text(
                    userEmail ?? "",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 2,
                  child: const Text(
                    "Выйти",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 2) {
                  Future.delayed(Duration.zero, () => _logout());
                }
              },
            ),
        ],
      ),
      body: Column(
        children: [
          if (userName != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Здравствуйте, $userName 👋',
                style: const TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 18,
                ),
              ),
            ),
          if (lastOpened != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Последняя открытая категория: $lastOpened',
                style: const TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 16,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final title = categories[index]['title'] as String;
                return Card(
                  color: const Color(0xFF2C2C2C),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Icon(
                      categories[index]['icon'] as IconData,
                      color: Colors.orangeAccent,
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                    onTap: () async {
                      await _saveLastOpened(title);
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(title: title),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailsScreen(title: 'Предметы'),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
