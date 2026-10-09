import 'package:flutter/material.dart';

/// Task 10: Structural Containers (Card & ExpansionTile).
class ContainersScreen extends StatelessWidget {
  const ContainersScreen({super.key});

  static const _faqs = [
    (
      'What is Flutter?',
      'Flutter is Google\'s open-source UI toolkit for building natively '
          'compiled applications for mobile, web and desktop from a single '
          'codebase.',
    ),
    (
      'What is the difference between Stateless and Stateful widgets?',
      'A StatelessWidget is immutable and rebuilds only when its parent '
          'changes. A StatefulWidget owns a State object and can rebuild '
          'itself by calling setState().',
    ),
    (
      'How do I add images to my app?',
      'Place the files in an assets folder, register them under the '
          '"assets" section of pubspec.yaml, then display them with '
          'Image.asset().',
    ),
    (
      'What does hot reload do?',
      'Hot reload injects updated source code into the running Dart VM so '
          'you can see UI changes instantly without losing app state.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Task 10: Cards & FAQ')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const InfoCard(),
          const SizedBox(height: 24),
          // Exercise 10.2: FAQ built from ExpansionTiles.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Text(
              'Frequently Asked Questions',
              style: textTheme.titleLarge,
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (final (question, answer) in _faqs)
                  ExpansionTile(
                    leading: const Icon(Icons.help_outline),
                    title: Text(question),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    expandedAlignment: Alignment.centerLeft,
                    children: [Text(answer)],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Exercise 10.1: Card with header, subtitle, leading Icon and trailing
/// action button.
class InfoCard extends StatefulWidget {
  const InfoCard({super.key});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool _bookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.school, size: 40),
              title: const Text(
                'Mobile Programming',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: const Text('Lab 4 · Flutter Mobile Widgets'),
              trailing: IconButton(
                tooltip: _bookmarked ? 'Remove bookmark' : 'Bookmark',
                icon: Icon(
                  _bookmarked ? Icons.bookmark : Icons.bookmark_border,
                ),
                onPressed: () => setState(() => _bookmarked = !_bookmarked),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                'Explore essential Flutter UI widgets for cross-platform '
                'mobile development across 10 widget categories.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
