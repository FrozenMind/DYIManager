import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/project.dart';

class ProjectDetail extends StatefulWidget {
  Project project;

  ProjectDetail(Project project) {
    this.project = project;
  }

  @override
  ProjectDetailState createState() => ProjectDetailState(project);
}

class ProjectDetailState extends State<ProjectDetail> {
  Project project;

  ProjectDetailState(Project project) {
    this.project = project;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail View'),
        ),
        body: _buildProject()
    );
  }

  Widget _buildProject() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Text>[
          Text(
            project.title,
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'Duration: ${project.duration.toString()}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
          Text(
            'Costs: ${project.duration.toString()}',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
