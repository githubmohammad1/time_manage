import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/clases.dart';

class TimeEntryProvider with ChangeNotifier {
  List<TimeEntry> _entries = [];

  List<TimeEntry> get entries => _entries;

  TimeEntryProvider() {
    _loadEntries();
  }

  void addTimeEntry(TimeEntry entry) {
    _entries.add(entry);
    _saveEntries();
    notifyListeners();
  }

  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    _saveEntries();
    notifyListeners();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getStringList('timeEntries');
    if (entriesJson != null) {
      _entries =
          entriesJson
              .map((json) => TimeEntry.fromJson(jsonDecode(json)))
              .toList();
      notifyListeners();
    }
  }

  Future<void> _saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson =
        _entries.map((entry) => jsonEncode(entry.toJson())).toList();
    await prefs.setStringList('timeEntries', entriesJson);
  }

  Map<String, Duration> getTimeSpentByProject() {
    Map<String, Duration> projectTimes = {};
    for (var entry in _entries) {
      if (projectTimes.containsKey(entry.projectId)) {
        projectTimes[entry.projectId] =
            projectTimes[entry.projectId]! + entry.totalTime;
      } else {
        projectTimes[entry.projectId] = entry.totalTime;
      }
    }
    return projectTimes;
  }

  Map<String, List<TimeEntry>> groupEntriesByProject() {
    Map<String, List<TimeEntry>> grouped = {};
    for (var entry in _entries) {
      if (!grouped.containsKey(entry.projectId)) {
        grouped[entry.projectId] = [];
      }
      grouped[entry.projectId]!.add(entry);
    }
    return grouped;
  }

  List<Project> _projects = [Project(id: '1', name: 'مشروع افتراضي')];

  List<Project> get projects => _projects;

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  void updateProject(Project updatedProject) {
    final index = _projects.indexWhere(
      (project) => project.id == updatedProject.id,
    );
    if (index != -1) {
      _projects[index] = updatedProject;
      notifyListeners();
    }
  }

  void deleteProject(String id) {
    _projects.removeWhere((project) => project.id == id);
    notifyListeners();
  }

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
