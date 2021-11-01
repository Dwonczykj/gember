import 'package:flutter/material.dart';

import 'green_project.dart';

class ProjectManager extends ChangeNotifier {
  final _projects = <GreenProject>[];
  int _selectedIndex = -1;
  bool _createNewProject = false;

  List<GreenProject> get projects => List.unmodifiable(_projects);
  int get selectedIndex => _selectedIndex;
  GreenProject? get selectedGroceryProject =>
      _selectedIndex != -1 ? _projects[_selectedIndex] : null;
  bool get isCreatingNewProject => _createNewProject;

  void createNewProject() {
    _createNewProject = true;
    notifyListeners();
  }

  void deleteProject(int index) {
    _projects.removeAt(index);
    notifyListeners();
  }

  void projectTapped(int index) {
    _selectedIndex = index;
    _createNewProject = false;
    notifyListeners();
  }

  void addProject(GreenProject project) {
    _projects.add(project);
    _createNewProject = false;
    notifyListeners();
  }

  void updateProject(GreenProject project, int index) {
    _projects[index] = project;
    _selectedIndex = -1;
    _createNewProject = false;
    notifyListeners();
  }
}
