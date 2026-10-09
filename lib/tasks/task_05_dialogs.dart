import 'package:flutter/material.dart';

/// Task 5: Dialogs & Modals (AlertDialog & showModalBottomSheet).
class DialogsScreen extends StatefulWidget {
  const DialogsScreen({super.key});

  @override
  State<DialogsScreen> createState() => _DialogsScreenState();
}

class _DialogsScreenState extends State<DialogsScreen> {
  final List<String> _documents = [
    'Project Proposal.pdf',
    'Lab Report.docx',
    'Budget 2026.xlsx',
    'Meeting Notes.txt',
  ];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  // Exercise 5.1: confirmation dialog with "Cancel" and "Delete" actions.
  Future<void> _confirmDelete(String document) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded),
        title: const Text('Delete item?'),
        content: Text('"$document" will be permanently removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() => _documents.remove(document));
      _showMessage('Deleted "$document"');
    }
  }

  // Exercise 5.2: bottom action sheet containing share options.
  void _showShareSheet(String document) {
    const options = [
      (Icons.link, 'Copy link'),
      (Icons.email, 'Email'),
      (Icons.message, 'Message'),
      (Icons.cloud_upload, 'Save to Drive'),
    ];

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Share "$document"',
                style: Theme.of(sheetContext).textTheme.titleMedium,
              ),
            ),
            for (final (icon, label) in options)
              ListTile(
                leading: Icon(icon),
                title: Text(label),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _showMessage('$label: $document');
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 5: Dialogs')),
      body: _documents.isEmpty
          ? const Center(child: Text('No documents left'))
          : ListView.builder(
              itemCount: _documents.length,
              itemBuilder: (context, index) {
                final document = _documents[index];
                return ListTile(
                  leading: const Icon(Icons.insert_drive_file),
                  title: Text(document),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Share',
                        icon: const Icon(Icons.share),
                        onPressed: () => _showShareSheet(document),
                      ),
                      IconButton(
                        tooltip: 'Delete',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _confirmDelete(document),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
