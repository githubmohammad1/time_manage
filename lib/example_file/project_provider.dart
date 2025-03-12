// import 'package:flutter/material.dart';
// import '../models/clases.dart';

// class ProjectProvider with ChangeNotifier {
//   List<Project> _projects = [Project(id: '1', name: 'مشروع افتراضي')];

//   List<Project> get projects => _projects;

//   void addProject(Project project) {
//     _projects.add(project);
//     notifyListeners();
//   }

//   void updateProject(Project updatedProject) {
//     final index = _projects.indexWhere(
//       (project) => project.id == updatedProject.id,
//     );
//     if (index != -1) {
//       _projects[index] = updatedProject;
//       notifyListeners();
//     }
//   }

//   void deleteProject(String id) {
//     _projects.removeWhere((project) => project.id == id);
//     notifyListeners();
//   }
// }
