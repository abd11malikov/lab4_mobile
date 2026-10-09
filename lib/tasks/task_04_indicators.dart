import 'package:flutter/material.dart';

/// Task 4: Indicators & Feedback (CircularProgressIndicator & SnackBar).
class IndicatorsScreen extends StatefulWidget {
  const IndicatorsScreen({super.key});

  @override
  State<IndicatorsScreen> createState() => _IndicatorsScreenState();
}

class _IndicatorsScreenState extends State<IndicatorsScreen> {
  bool _isLoading = false;
  int _syncedFiles = 0;

  Future<void> _startSync() async {
    // Exercise 4.1: show a centered spinner for 3 seconds.
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _syncedFiles++;
    });

    // Exercise 4.2: SnackBar with an "Undo" action upon completion.
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: const Text('File synced successfully'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            if (!mounted) return;
            setState(() => _syncedFiles--);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 4: Feedback')),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_sync, size: 72),
                const SizedBox(height: 12),
                Text(
                  'Synced files: $_syncedFiles',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _startSync,
                  icon: const Icon(Icons.sync),
                  label: const Text('Sync File'),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.black38,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}
