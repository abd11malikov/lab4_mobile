import 'package:flutter/material.dart';

import 'core_example/media_profile_card.dart';
import 'tasks/task_01_selection_controls.dart';
import 'tasks/task_02_input_fields.dart';
import 'tasks/task_03_buttons.dart';
import 'tasks/task_04_indicators.dart';
import 'tasks/task_05_dialogs.dart';
import 'tasks/task_06_sliders_pickers.dart';
import 'tasks/task_07_scrollable_list.dart';
import 'tasks/task_08_grid_gallery.dart';
import 'tasks/task_09_navigation.dart';
import 'tasks/task_10_containers.dart';
import 'theme_controller.dart';

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Lab 4: Flutter Widgets',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.light,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}

class _LabEntry {
  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder builder;

  const _LabEntry(this.title, this.subtitle, this.icon, this.builder);
}

final List<_LabEntry> _entries = [
  _LabEntry(
    'Core Example',
    'Icon & Image widgets',
    Icons.person,
    (_) => const CoreExampleScreen(),
  ),
  _LabEntry(
    'Task 1',
    'Selection Controls (Checkbox & Switch)',
    Icons.toggle_on,
    (_) => const SelectionControlsScreen(),
  ),
  _LabEntry(
    'Task 2',
    'Input Fields (TextFormField)',
    Icons.login,
    (_) => const LoginFormScreen(),
  ),
  _LabEntry(
    'Task 3',
    'Buttons (FAB & OutlinedButton)',
    Icons.add_circle,
    (_) => const CounterScreen(),
  ),
  _LabEntry(
    'Task 4',
    'Indicators & Feedback',
    Icons.hourglass_top,
    (_) => const IndicatorsScreen(),
  ),
  _LabEntry(
    'Task 5',
    'Dialogs & Modals',
    Icons.chat_bubble,
    (_) => const DialogsScreen(),
  ),
  _LabEntry(
    'Task 6',
    'Sliders & Pickers',
    Icons.tune,
    (_) => const SlidersPickersScreen(),
  ),
  _LabEntry(
    'Task 7',
    'Scrollable List (ListView.builder)',
    Icons.list,
    (_) => const DynamicListScreen(),
  ),
  _LabEntry(
    'Task 8',
    'Grid Gallery (GridView.count)',
    Icons.grid_view,
    (_) => const GridGalleryScreen(),
  ),
  _LabEntry(
    'Task 9',
    'Navigation (BottomNavigationBar & TabBar)',
    Icons.navigation,
    (_) => const NavigationScreen(),
  ),
  _LabEntry(
    'Task 10',
    'Structural Containers (Card & ExpansionTile)',
    Icons.view_agenda,
    (_) => const ContainersScreen(),
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4: Flutter Widgets')),
      body: ListView.separated(
        itemCount: _entries.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final entry = _entries[index];
          return ListTile(
            leading: CircleAvatar(child: Icon(entry.icon)),
            title: Text(entry.title),
            subtitle: Text(entry.subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: entry.builder)),
          );
        },
      ),
    );
  }
}
