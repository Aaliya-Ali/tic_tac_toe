import 'package:flutter/material.dart';

class ReusableCard {
  final id;
  String text;
  Color bg;
  bool enabled;

  ReusableCard(
      {this.id, this.text = "", this.bg = Colors.white24, this.enabled = true});
}
