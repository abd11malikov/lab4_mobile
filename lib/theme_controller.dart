import 'package:flutter/material.dart';

/// App-wide theme mode, toggled by the "Dark Mode" switch in Task 1.
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier<ThemeMode>(
  ThemeMode.light,
);
