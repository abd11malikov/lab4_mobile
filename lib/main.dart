import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _setDarkMode(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Flutter Widgets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: HomeScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        onDarkModeChanged: _setDarkMode,
      ),
    );
  }
}

// =============================================================================
// HOME SCREEN: menu that opens the core example and all 10 tasks
// =============================================================================
class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = <(String, IconData, Widget)>[
      ('Core Example: Icon & Image', Icons.person, const CoreExampleScreen()),
      (
        'Task 1: Selection Controls',
        Icons.toggle_on,
        Task1Screen(
          isDarkMode: isDarkMode,
          onDarkModeChanged: onDarkModeChanged,
        ),
      ),
      ('Task 2: Input Fields', Icons.login, const Task2Screen()),
      ('Task 3: Buttons & Actions', Icons.add_circle, const Task3Screen()),
      (
        'Task 4: Indicators & Feedback',
        Icons.hourglass_top,
        const Task4Screen(),
      ),
      ('Task 5: Dialogs & Modals', Icons.chat_bubble, const Task5Screen()),
      ('Task 6: Sliders & Pickers', Icons.tune, const Task6Screen()),
      ('Task 7: Scrollable Collections', Icons.list, const Task7Screen()),
      ('Task 8: Grid Displays', Icons.grid_view, const Task8Screen()),
      ('Task 9: Navigation Controls', Icons.navigation, const Task9Screen()),
      (
        'Task 10: Structural Containers',
        Icons.view_agenda,
        const Task10Screen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4: Flutter Widgets')),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final (title, icon, screen) = items[index];
          return ListTile(
            leading: CircleAvatar(child: Icon(icon)),
            title: Text(title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => screen),
            ),
          );
        },
      ),
    );
  }
}

// =============================================================================
// 2. CORE EXAMPLE: Icon & Image widgets (MediaProfileCard)
// =============================================================================
class CoreExampleScreen extends StatelessWidget {
  const CoreExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Core Example')),
      body: const Center(child: MediaProfileCard()),
    );
  }
}

class MediaProfileCard extends StatefulWidget {
  const MediaProfileCard({super.key});

  @override
  State<MediaProfileCard> createState() => _MediaProfileCardState();
}

class _MediaProfileCardState extends State<MediaProfileCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              // Network image so the app needs no asset files.
              // errorBuilder shows a placeholder icon when offline.
              child: Image.network(
                'https://picsum.photos/id/64/240/240',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 40),
                  );
                },
              ),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'User Profile Card',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            // Interactive Icon widget
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 28.0,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 3.1 TASK 1: Selection Controls (Checkbox & Switch)
// =============================================================================
class Task1Screen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const Task1Screen({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<Task1Screen> createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  late bool _darkMode = widget.isDarkMode;
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 1: Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // Exercise 1.1: SwitchListTile for "Dark Mode" (changes app theme)
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            subtitle: const Text('Switch between light and dark theme'),
            value: _darkMode,
            onChanged: (value) {
              setState(() => _darkMode = value);
              widget.onDarkModeChanged(value);
            },
          ),
          const Divider(),
          // Exercise 1.1: CheckboxListTile for "Agree to Terms"
          CheckboxListTile(
            secondary: const Icon(Icons.description),
            title: const Text('Agree to Terms'),
            subtitle: const Text('I have read and accept the terms'),
            value: _agreeToTerms,
            onChanged: (value) {
              setState(() => _agreeToTerms = value ?? false);
            },
          ),
          const SizedBox(height: 24),
          // Exercise 1.2: button is enabled only when terms are accepted
          // (onPressed: null renders the button disabled)
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

// =============================================================================
// 3.2 TASK 2: Input Fields (TextField & TextFormField)
// =============================================================================
class Task2Screen extends StatefulWidget {
  const Task2Screen({super.key});

  @override
  State<Task2Screen> createState() => _Task2ScreenState();
}

class _Task2ScreenState extends State<Task2Screen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    // Exercise 2.2: run all validators before submitting
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged in as ${_emailController.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 2: Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.lock_person, size: 72),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                // Exercise 2.2: email must contain an "@" symbol
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Email must contain an @ symbol';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Exercise 2.1: password field with obscure text toggle
              TextFormField(
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _submit, child: const Text('Log In')),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 3.3 TASK 3: Buttons & Action Items (FloatingActionButton & OutlinedButton)
// =============================================================================
class Task3Screen extends StatefulWidget {
  const Task3Screen({super.key});

  @override
  State<Task3Screen> createState() => _Task3ScreenState();
}

class _Task3ScreenState extends State<Task3Screen> {
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
            // Exercise 3.2: OutlinedButton resets the counter to 0
            OutlinedButton.icon(
              onPressed: () => setState(() => _counter = 0),
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset'),
            ),
          ],
        ),
      ),
      // Exercise 3.1: FAB in the bottom corner increments the counter
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// =============================================================================
// 3.4 TASK 4: Indicators & Feedback (CircularProgressIndicator & SnackBar)
// =============================================================================
class Task4Screen extends StatefulWidget {
  const Task4Screen({super.key});

  @override
  State<Task4Screen> createState() => _Task4ScreenState();
}

class _Task4ScreenState extends State<Task4Screen> {
  bool _isLoading = false;
  int _syncedFiles = 0;

  Future<void> _syncFile() async {
    // Exercise 4.1: show a centered spinner for 3 seconds
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _syncedFiles++;
    });

    // Exercise 4.2: SnackBar with an "Undo" action upon completion
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('File synced successfully'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              if (mounted) setState(() => _syncedFiles--);
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 4: Feedback')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
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
                    onPressed: _syncFile,
                    icon: const Icon(Icons.sync),
                    label: const Text('Sync File'),
                  ),
                ],
              ),
      ),
    );
  }
}

// =============================================================================
// 3.5 TASK 5: Dialogs & Modals (AlertDialog & showModalBottomSheet)
// =============================================================================
class Task5Screen extends StatefulWidget {
  const Task5Screen({super.key});

  @override
  State<Task5Screen> createState() => _Task5ScreenState();
}

class _Task5ScreenState extends State<Task5Screen> {
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

  // Exercise 5.1: AlertDialog with "Cancel" and "Delete" actions
  Future<void> _confirmDelete(String document) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded),
        title: const Text('Delete item?'),
        content: Text('"$document" will be permanently removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.pop(dialogContext, true),
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

  // Exercise 5.2: bottom action sheet with share options (ListTile items)
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
            Text(
              'Share "$document"',
              style: Theme.of(sheetContext).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            for (final (icon, label) in options)
              ListTile(
                leading: Icon(icon),
                title: Text(label),
                onTap: () {
                  Navigator.pop(sheetContext);
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
                        icon: const Icon(Icons.share),
                        onPressed: () => _showShareSheet(document),
                      ),
                      IconButton(
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

// =============================================================================
// 3.6 TASK 6: Sliders & Pickers (Slider & showDatePicker)
// =============================================================================
class Task6Screen extends StatefulWidget {
  const Task6Screen({super.key});

  @override
  State<Task6Screen> createState() => _Task6ScreenState();
}

class _Task6ScreenState extends State<Task6Screen> {
  double _volume = 50;
  DateTime? _selectedDate;

  IconData get _volumeIcon {
    if (_volume == 0) return Icons.volume_off;
    if (_volume < 50) return Icons.volume_down;
    return Icons.volume_up;
  }

  // Exercise 6.2: open the native date picker
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // Formatted like "Friday, October 9, 2026"
    final dateText = _selectedDate == null
        ? 'No date selected'
        : MaterialLocalizations.of(context).formatFullDate(_selectedDate!);

    return Scaffold(
      appBar: AppBar(title: const Text('Task 6: Sliders & Pickers')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Exercise 6.1: volume Slider with a live percentage text
          Text('Volume', style: textTheme.titleLarge),
          Row(
            children: [
              Icon(_volumeIcon),
              Expanded(
                child: Slider(
                  value: _volume,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: '${_volume.round()}%',
                  onChanged: (value) => setState(() => _volume = value),
                ),
              ),
              Text('${_volume.round()}%', style: textTheme.titleMedium),
            ],
          ),
          const Divider(height: 48),
          // Exercise 6.2: date picker button + formatted date
          Text('Date', style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(dateText, style: textTheme.titleMedium),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_month),
              label: const Text('Pick a date'),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 3.7 TASK 7: Scrollable Collections (ListView.builder & ListTile)
// =============================================================================
class Task7Screen extends StatefulWidget {
  const Task7Screen({super.key});

  @override
  State<Task7Screen> createState() => _Task7ScreenState();
}

class _Task7ScreenState extends State<Task7Screen> {
  // Exercise 7.1: dynamic list of 20 items
  final List<int> _items = List.generate(20, (i) => i + 1);

  void _removeItem(int index) {
    final removed = _items[index];
    setState(() => _items.removeAt(index));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Item $removed dismissed'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              if (mounted) setState(() => _items.insert(index, removed));
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task 7: List (${_items.length} items)')),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          // Exercise 7.2: swipe-to-dismiss with Dismissible
          return Dismissible(
            key: ValueKey(item),
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Icon(Icons.archive, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => _removeItem(index),
            child: ListTile(
              leading: CircleAvatar(child: Text('$item')),
              title: Text('List item $item'),
              subtitle: const Text('Swipe left or right to dismiss'),
            ),
          );
        },
      ),
    );
  }
}

// =============================================================================
// 3.8 TASK 8: Grid Displays (GridView.count)
// =============================================================================
class Task8Screen extends StatelessWidget {
  const Task8Screen({super.key});

  static final List<String> _imageUrls = List.generate(
    10,
    (i) => 'https://picsum.photos/id/${i + 10}/400/400',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 8: Gallery')),
      // Exercise 8.1: 2-column gallery with cross-axis spacing
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: const EdgeInsets.all(12),
        children: [
          for (final url in _imageUrls)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: url,
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) =>
                          progress == null
                          ? child
                          : const Center(child: CircularProgressIndicator()),
                      errorBuilder: (context, error, stackTrace) =>
                          const ColoredBox(
                            color: Colors.grey,
                            child: Icon(Icons.broken_image, size: 40),
                          ),
                    ),
                  ),
                  // Exercise 8.2: InkWell opens a full-screen preview on tap
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullScreenImage(imageUrl: url),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: InteractiveViewer(
            maxScale: 4,
            child: Hero(
              tag: imageUrl,
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 3.9 TASK 9: Navigation Controls (BottomNavigationBar & TabBar)
// =============================================================================
class Task9Screen extends StatefulWidget {
  const Task9Screen({super.key});

  @override
  State<Task9Screen> createState() => _Task9ScreenState();
}

class _Task9ScreenState extends State<Task9Screen> {
  int _currentIndex = 0;

  static const _titles = ['Home', 'Messages', 'Profile'];

  Widget _placeholder(IconData icon, String text) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 72, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(text, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // DefaultTabController shares one controller between TabBar and TabBarView
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Task 9: ${_titles[_currentIndex]}'),
          // Exercise 9.2: top TabBar inside the AppBar (on the Messages view)
          bottom: _currentIndex == 1
              ? const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.chat), text: 'Chats'),
                    Tab(icon: Icon(Icons.call), text: 'Calls'),
                    Tab(icon: Icon(Icons.update), text: 'Status'),
                  ],
                )
              : null,
        ),
        body: switch (_currentIndex) {
          0 => _placeholder(Icons.home, 'Welcome home!'),
          1 => TabBarView(
            children: [
              _placeholder(Icons.chat, 'No new chats'),
              _placeholder(Icons.call, 'No recent calls'),
              _placeholder(Icons.update, 'No status updates'),
            ],
          ),
          _ => _placeholder(Icons.person, 'Your profile'),
        },
        // Exercise 9.1: 3-tab BottomNavigationBar that switches views
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 3.10 TASK 10: Structural Containers (Card & ExpansionTile)
// =============================================================================
class Task10Screen extends StatefulWidget {
  const Task10Screen({super.key});

  @override
  State<Task10Screen> createState() => _Task10ScreenState();
}

class _Task10ScreenState extends State<Task10Screen> {
  bool _bookmarked = false;

  static const _faqs = [
    (
      'What is Flutter?',
      'Flutter is Google\'s open-source UI toolkit for building natively '
          'compiled apps for mobile, web and desktop from one codebase.',
    ),
    (
      'Stateless vs Stateful widgets?',
      'A StatelessWidget is immutable. A StatefulWidget owns a State object '
          'and can rebuild itself by calling setState().',
    ),
    (
      'How do I add images to my app?',
      'Use Image.network for URLs, or put files in an assets folder, '
          'register them in pubspec.yaml and use Image.asset.',
    ),
    (
      'What does hot reload do?',
      'It injects updated code into the running Dart VM so UI changes appear '
          'instantly without losing app state.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 10: Cards & FAQ')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Exercise 10.1: Card with header, subtitle, leading Icon
          // and trailing action button
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.school, size: 40),
                    title: const Text(
                      'Mobile Programming',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: const Text('Lab 4 · Flutter Mobile Widgets'),
                    trailing: IconButton(
                      icon: Icon(
                        _bookmarked ? Icons.bookmark : Icons.bookmark_border,
                      ),
                      onPressed: () =>
                          setState(() => _bookmarked = !_bookmarked),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Text(
                      'Explore essential Flutter UI widgets for '
                      'cross-platform mobile development.',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Frequently Asked Questions',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          // Exercise 10.2: FAQ built from multiple ExpansionTiles
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
