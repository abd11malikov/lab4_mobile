import 'package:flutter/material.dart';

/// Task 6: Sliders & Pickers (Slider & showDatePicker).
class SlidersPickersScreen extends StatefulWidget {
  const SlidersPickersScreen({super.key});

  @override
  State<SlidersPickersScreen> createState() => _SlidersPickersScreenState();
}

class _SlidersPickersScreenState extends State<SlidersPickersScreen> {
  double _volume = 50;
  DateTime? _selectedDate;

  IconData get _volumeIcon {
    if (_volume == 0) return Icons.volume_off;
    if (_volume < 50) return Icons.volume_down;
    return Icons.volume_up;
  }

  // Exercise 6.2: open the native date picker.
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
    // Locale-aware formatting, e.g. "Friday, October 9, 2026".
    final formattedDate = _selectedDate == null
        ? 'No date selected'
        : MaterialLocalizations.of(context).formatFullDate(_selectedDate!);

    return Scaffold(
      appBar: AppBar(title: const Text('Task 6: Sliders & Pickers')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Exercise 6.1: volume control with a live percentage label.
          Text('Volume', style: textTheme.titleLarge),
          const SizedBox(height: 8),
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
              SizedBox(
                width: 56,
                child: Text(
                  '${_volume.round()}%',
                  textAlign: TextAlign.end,
                  style: textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const Divider(height: 48),
          Text('Date', style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(formattedDate, style: textTheme.titleMedium),
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
