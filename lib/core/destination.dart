import 'package:flutter/material.dart';

class Destination {
  const Destination({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

const destinations = [
  Destination(label: 'Home', icon: Icons.home_rounded),
  Destination(label: 'History', icon: Icons.history_rounded),
  Destination(label: 'Chart', icon: Icons.ssid_chart_rounded),
  Destination(label: 'Settings', icon: Icons.settings_rounded),
];
