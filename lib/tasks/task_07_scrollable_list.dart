import 'package:flutter/material.dart';

/// Task 7: Scrollable Collections (ListView.builder & ListTile).
class DynamicListScreen extends StatefulWidget {
  const DynamicListScreen({super.key});

  @override
  State<DynamicListScreen> createState() => _DynamicListScreenState();
}

class _DynamicListScreenState extends State<DynamicListScreen> {
  // Exercise 7.1: 20 generated items. Each item keeps a stable id so
  // Dismissible keys stay unique after removals.
  final List<int> _items = List<int>.generate(20, (i) => i + 1);

  void _removeItem(int index) {
    final removed = _items.removeAt(index);
    setState(() {});

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Item $removed dismissed'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              if (!mounted) return;
              setState(() => _items.insert(index, removed));
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('Task 7: List (${_items.length} items)')),
      body: _items.isEmpty
          ? const Center(child: Text('All items dismissed'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                // Exercise 7.2: swipe-to-dismiss with Dismissible.
                return Dismissible(
                  key: ValueKey<int>(item),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.archive, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _removeItem(index),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colors.primaryContainer,
                      child: Text('$item'),
                    ),
                    title: Text('List item $item'),
                    subtitle: const Text('Swipe left or right to dismiss'),
                    trailing: const Icon(Icons.drag_handle),
                  ),
                );
              },
            ),
    );
  }
}
