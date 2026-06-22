import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<SettingsCubit, bool>(
              builder: (context, isDarkMode) {
                return ListTile(
                  title: const Text('Dark Mode'),
                  trailing: Switch.adaptive(
                    value: isDarkMode,
                    onChanged: (value) {
                      context.read<SettingsCubit>().toggleTheme(value);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
