import 'package:dyi_manager/projectDetail.dart';
import 'package:dyi_manager/projectEdit.dart';
import 'package:flutter/material.dart';
import 'model/project.dart';

class ProjectsOverview extends StatefulWidget {
  @override
  ProjectsOverviewState createState() => ProjectsOverviewState();
}

class ProjectsOverviewState extends State<ProjectsOverview> {
  final bloc = ProjectBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Projects'),
      ),
      body: _buildProjects(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ProjectEdit(null, bloc)))
        },
        tooltip: 'Add Project',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildProjects() {
    return StreamBuilder<List<Project>>(
        stream: bloc.projects,
        builder: (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Project item = snapshot.data[index];
                return ListTile(
                  key: Key(item.id.toString()),
                  leading: Icon(item.icon),
                  title: Text(item.title,),
                  subtitle: Text('${item.duration}h - ${item.costs}€'),
                  onTap: () =>
                  {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProjectDetail(item)))
                  },
                  onLongPress: () =>
                  {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProjectEdit(item, bloc)))
                  },
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }

}
