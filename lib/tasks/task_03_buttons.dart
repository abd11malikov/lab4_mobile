import 'package:flutter/material.dart';

/// Task 3: Buttons & Action Items (FloatingActionButton & OutlinedButton).
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 3: Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            const SizedBox(height: 8),
            Text('$_counter', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 24),
            // Exercise 3.2: secondary OutlinedButton resets the counter.
            OutlinedButton.icon(
              onPressed: () => setState(() => _counter = 0),
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset'),
            ),
          ],
        ),
      ),
      // Exercise 3.1: FAB in the bottom corner increments the counter.
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () => setState(() => _counter++),
        child: const Icon(Icons.add),
      ),
    );
  }
}
