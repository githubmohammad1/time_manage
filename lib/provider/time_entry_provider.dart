import 'package:flutter/material.dart';
import 'package:time_tracker/models/time_entry.dart';

class TimeEntryProvider with ChangeNotifier {
  final List<TimeEntry> _entries = [];

  List<TimeEntry> get entries => _entries;

  void addTimeEntry(TimeEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    notifyListeners();
  }

  // إضافة وظائف لتعديل إدخالات الوقت
  // إضافة وظائف للتخزين المحلي
  // اضافة وظائف للتعامل مع المشاريع و المهام.
  // اضافة وظائف للتعامل مع الوقت و تحويله من و الى Duration.
}
