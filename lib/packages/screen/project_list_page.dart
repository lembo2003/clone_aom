import 'package:clone_aom/packages/screen/components/project_list_tile.dart';
import 'package:flutter/material.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Project list page')),
      body: Center(
        child: ProjectListTile(
          projectName: 'projectName',
          projectId: 'projectId',
          endDate: 'endDate',
          teamSize: 'teamSize',
          progressPercent: 'progressPercent',
          state: 'state',
        ),
      ),
    );
  }
}
