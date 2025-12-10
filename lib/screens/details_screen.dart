import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class DetailsScreen extends StatefulWidget {
  final String title;

  const DetailsScreen({super.key, required this.title});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> filteredItems = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadItems();
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredItems = items;
      } else {
        filteredItems = items
            .where((item) =>
                (item['name'] as String).toLowerCase().contains(query) ||
                (item['effect'] as String).toLowerCase().contains(query) ||
                (item['type'] as String).toLowerCase().contains(query))
            .toList();
      }
    });
  }

  Future<void> _loadItems() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/items.json');
      final jsonData = jsonDecode(jsonString) as List;
      setState(() {
        items = jsonData
            .map((item) => {
                  'name': item['name'] as String,
                  'effect': item['effect'] as String,
                  'type': item['type'] as String,
                  'icon': _getIcon(item['icon'] as String),
                })
            .toList();
        filteredItems = items;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  IconData _getIcon(String iconName) {
    final iconMap = {
      'casino': Icons.casino,
      'whatshot': Icons.whatshot,
      'star': Icons.star,
      'flash_on': Icons.flash_on,
      'water_drop': Icons.water_drop,
      'speed': Icons.speed,
      'pets': Icons.pets,
      'grade': Icons.grade,
      'cloud': Icons.cloud,
      'favorite': Icons.favorite,
      'shield': Icons.shield,
      'bubble_chart': Icons.bubble_chart,
    };
    return iconMap[iconName] ?? Icons.help;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.title == 'Предметы') {
      return _buildItemsScreen(context);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E2E2E),
        title: Text(widget.title,
            style: const TextStyle(color: Colors.orangeAccent)),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF1B1B1B),
      body: Center(
        child: Text(
          'Здесь будет информация о категории "${widget.title}"',
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildItemsScreen(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E2E2E),
          title: const Text(
            'Предметы The Binding of Isaac',
            style: TextStyle(color: Colors.orangeAccent),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFF1B1B1B),
        body: const Center(
          child: CircularProgressIndicator(color: Colors.orangeAccent),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E2E2E),
        title: const Text(
          'Предметы The Binding of Isaac',
          style: TextStyle(color: Colors.orangeAccent),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF1B1B1B),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Поиск предмета...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.orangeAccent),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.orangeAccent),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF2C2C2C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.orangeAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.orangeAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.orangeAccent, width: 2),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Text(
                      _searchController.text.isEmpty
                          ? 'Нет предметов'
                          : 'Предметы не найдены',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return Card(
                        color: const Color(0xFF2C2C2C),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ExpansionTile(
                          leading: Icon(
                            item['icon'] as IconData,
                            color: Colors.orangeAccent,
                            size: 28,
                          ),
                          title: Text(
                            item['name']!,
                            style: const TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            item['type']!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                          collapsedIconColor: Colors.orangeAccent,
                          iconColor: Colors.orangeAccent,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Эффект:',
                                    style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item['effect']!,
                                    style: const TextStyle(
                                        color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
