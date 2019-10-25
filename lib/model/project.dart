import 'dart:async';

import 'package:dyi_manager/dbHandler.dart';
import 'package:flutter/material.dart';

class Project {
  int id;
  String title;
  int duration;
  int costs;
  IconData icon = Icons.cloud_queue;

  Project({this.id, this.title, this.duration, this.costs}) {}

  factory Project.fromJson(Map<String, dynamic> json) => new Project(
    id: json["id"],
    title: json["title"],
    duration: json["duration"],
    costs: json["costs"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "duration": duration,
    "costs": costs,
  };
}

class ProjectBloc {
  ProjectBloc() {
    getAllProjects();
  }
  final _projectController = StreamController<List<Project>>.broadcast();
  get projects => _projectController.stream;

  dispose() {
    _projectController.close();
  }

  getAllProjects() async {
    _projectController.sink.add(await DBHandler.db.getAllProjects());
  }

  newProject(Project newProject) {
    DBHandler.db.newProject(newProject);
    getAllProjects();
  }

  getProject(int id) {
    DBHandler.db.getProject(id);
    getAllProjects();
  }

  updateProject(Project project) {
    DBHandler.db.updateProject(project);
    getAllProjects();
  }

  deleteProject(int id) {
    DBHandler.db.deleteProject(id);
    getAllProjects();
  }

}