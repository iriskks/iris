import 'package:flutter/material.dart';
import '../models/game_item.dart';
import 'ItemDetailsScreen.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      GameItem(
        name: 'Brimstone',
        effect: 'Лазер ада',
        rarity: 'Легендарный',
        icon: Icons.flash_on,
      ),
      GameItem(
        name: 'Sacred Heart',
        effect: '+50% урон, автонаведение',
        rarity: 'Эпический',
        icon: Icons.favorite,
      ),
      GameItem(
        name: 'Polyphemus',
        effect: 'Огромный урон, медленная атака',
        rarity: 'Эпический',
        icon: Icons.remove_red_eye,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Предметы')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: Icon(item.icon, color: Colors.amber),
              title: Text(item.name),
              subtitle: Text(item.effect),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetailsScreen(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
