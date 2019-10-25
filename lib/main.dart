import 'package:dyi_manager/projectOverview.dart';
import 'package:flutter/material.dart';

void main() => runApp(DyiManager());

class DyiManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dyi Manger',
      home: ProjectsOverview(),
    );
  }
}







