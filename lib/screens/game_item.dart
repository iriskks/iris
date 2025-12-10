import 'package:flutter/material.dart';

class GameItem {
  final String name;
  final String effect;
  final String rarity;
  final IconData icon;

  GameItem({
    required this.name,
    required this.effect,
    required this.rarity,
    required this.icon,
  });
}
