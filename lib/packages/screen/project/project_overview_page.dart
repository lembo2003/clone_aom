import 'package:flutter/material.dart';

class ProjectOverviewPage extends StatelessWidget {
  final int? projectId;

  const ProjectOverviewPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Something'),
          SizedBox(height: 16),
          Text('Oh by the way, the project ID is $projectId'),
        ],
      ),
    );
  }
}
