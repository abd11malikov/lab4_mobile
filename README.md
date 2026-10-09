# Lab 4: Flutter Mobile Widgets

Laboratory Work 4 for Mobile Programming: the core Icon/Image example plus all
10 widget tasks. Each task is its own screen, reachable from the home list.

| # | Topic | File |
|---|-------|------|
| — | Core example: `Icon` & `Image.asset` (`MediaProfileCard`) | `lib/core_example/media_profile_card.dart` |
| 1 | `SwitchListTile` (Dark Mode, toggles app theme) + `CheckboxListTile` enabling an `ElevatedButton` | `lib/tasks/task_01_selection_controls.dart` |
| 2 | Login `Form` with `TextFormField`, password visibility toggle, `@` email validation | `lib/tasks/task_02_input_fields.dart` |
| 3 | Counter with `FloatingActionButton` (increment) and `OutlinedButton` (reset) | `lib/tasks/task_03_buttons.dart` |
| 4 | Centered `CircularProgressIndicator` for 3 s, then `SnackBar` with "Undo" | `lib/tasks/task_04_indicators.dart` |
| 5 | Delete confirmation `AlertDialog` + share sheet via `showModalBottomSheet` | `lib/tasks/task_05_dialogs.dart` |
| 6 | Volume `Slider` with live percentage + `showDatePicker` with formatted date | `lib/tasks/task_06_sliders_pickers.dart` |
| 7 | `ListView.builder` of 20 `ListTile`s with swipe-to-dismiss (`Dismissible`) | `lib/tasks/task_07_scrollable_list.dart` |
| 8 | 2-column `GridView.count` gallery, `InkWell` → full-screen `Hero` preview | `lib/tasks/task_08_grid_gallery.dart` |
| 9 | 3-tab `BottomNavigationBar`; "Messages" tab has `TabBar`/`TabBarView` in the `AppBar` | `lib/tasks/task_09_navigation.dart` |
| 10 | Info `Card` (header, subtitle, leading icon, trailing action) + FAQ with `ExpansionTile`s | `lib/tasks/task_10_containers.dart` |

## Running

The repo contains only the Dart sources, assets and `pubspec.yaml`. Generate
the Android/iOS platform folders once (existing files are not overwritten),
then run:

```bash
flutter create --platforms=android,ios .
flutter pub get
flutter run
```

Tests:

```bash
flutter test
```
