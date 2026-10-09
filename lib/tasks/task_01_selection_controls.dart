import 'package:flutter/material.dart';

import '../theme_controller.dart';

/// Task 1: Selection Controls (Checkbox & Switch).
class SelectionControlsScreen extends StatefulWidget {
  const SelectionControlsScreen({super.key});

  @override
  State<SelectionControlsScreen> createState() =>
      _SelectionControlsScreenState();
}

class _SelectionControlsScreenState extends State<SelectionControlsScreen> {
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 1: Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // Exercise 1.1: SwitchListTile for "Dark Mode".
          // Bound to the app-wide theme so the toggle has a visible effect.
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) {
              return SwitchListTile(
                secondary: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                subtitle: const Text('Switch between light and dark theme'),
                value: mode == ThemeMode.dark,
                onChanged: (enabled) {
                  themeModeNotifier.value = enabled
                      ? ThemeMode.dark
                      : ThemeMode.light;
                },
              );
            },
          ),
          const Divider(),
          // Exercise 1.1: CheckboxListTile for "Agree to Terms".
          CheckboxListTile(
            secondary: const Icon(Icons.description),
            title: const Text('Agree to Terms'),
            subtitle: const Text('I have read and accept the terms of service'),
            value: _agreeToTerms,
            onChanged: (checked) {
              setState(() => _agreeToTerms = checked ?? false);
            },
          ),
          const SizedBox(height: 24),
          // Exercise 1.2: Button is enabled only when terms are accepted.
          // Passing `null` to onPressed renders the button disabled.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: _agreeToTerms
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings saved!')),
                      );
                    }
                  : null,
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
