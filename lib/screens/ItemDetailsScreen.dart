import 'package:flutter/material.dart';
import '../models/game_item.dart';

class ItemDetailsScreen extends StatelessWidget {
  final GameItem item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(item.icon, size: 80, color: Colors.amber),
            const SizedBox(height: 20),
            Text(
              'Редкость: ${item.rarity}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Эффект: ${item.effect}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
