import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/project.dart';

class ProjectEdit extends StatefulWidget {
  Project project;
  ProjectBloc bloc;

  ProjectEdit(Project project, ProjectBloc bloc) {
    this.project = project;
    this.bloc = bloc;
  }

  @override
  ProjectEditState createState() => ProjectEditState(project, bloc);
}

class ProjectEditState extends State<ProjectEdit> {
  var titleCtrl = TextEditingController();
  var durationCtrl = TextEditingController();
  var costsCtrl = TextEditingController();

  Project project;
  ProjectBloc bloc;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (null != project.title) {
      titleCtrl.text = project.title;
    }
    if (null != project.duration) {
      durationCtrl.text = project.duration.toString();
    }
    if (null != project.costs) {
      costsCtrl.text = project.costs.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    durationCtrl.dispose();
    costsCtrl.dispose();
    super.dispose();
  }

  ProjectEditState(Project project, ProjectBloc bloc) {
    this.bloc = bloc;
    if (null != project) {
      this.project = project;
    } else {
      this.project = Project();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add/Edit Project'),
        ),
        body: _buildEditView()
    );
  }

  Widget _buildEditView() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: titleCtrl,
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Enter your title',
            ),
          ),
          TextField(
            controller: durationCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Duration',
              hintText: 'Enter the duration',
              prefixText: 'h ',
            ),
          ),
          TextField(
            controller: costsCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'costs',
              hintText: 'Enter the costs',
              prefixText: '€ ',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    project.title = titleCtrl.text;
                    if (null != durationCtrl.text) {
                      project.duration = int.parse(durationCtrl.text);
                    }
                    if (null != costsCtrl.text) {
                      project.costs = int.parse(costsCtrl.text);
                    }
                    if (null == project.id) {
                      bloc.newProject(project);
                    } else {
                      bloc.updateProject(project);
                    }
                    Navigator.pop(context);
                  },
                  color: Colors.green[500],
                  child: Text('SAVE'),
                ),
                RaisedButton(
                  onPressed: () {
                    if (null != project.id) {
                      bloc.deleteProject(project.id);
                    }
                    Navigator.pop(context);
                  },
                  color: Colors.red[500],
                  child: Text('DELETE'),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCEL'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
