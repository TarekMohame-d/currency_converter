import 'package:currency_converter/core/destination.dart';
import 'package:currency_converter/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        indicatorColor: Theme.of(context).primaryColor,
        destinations: destinations
            .map(
              (d) => NavigationDestination(
                label: d.label,
                icon: Icon(d.icon),
                selectedIcon: Icon(d.icon, color: KColors.white),
              ),
            )
            .toList(),
      ),
    );
  }
}
