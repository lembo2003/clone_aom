import 'package:clone_aom/packages/models/project/project_wbs_response.dart';
import 'package:clone_aom/packages/screen/components/project/task_list_tile.dart';
import 'package:clone_aom/packages/services/project_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectWbsPage extends StatefulWidget {
  final int? projectId;

  const ProjectWbsPage({super.key, required this.projectId});

  @override
  State<ProjectWbsPage> createState() => _ProjectWbsPageState();
}

class _ProjectWbsPageState extends State<ProjectWbsPage> {
  final ProjectApiServices _projectService = ProjectApiServices();
  Future<ProjectWbsResponse>? _futureWbs;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWbsData();
  }

  void _fetchWbsData() {
    if (widget.projectId != null) {
      _futureWbs = _projectService.fetchTaskList(widget.projectId!);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '--';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.grey[400],
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),

        // Create New Task Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade200,
                style: BorderStyle.solid,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // TODO: Implement create new task
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.deepPurple.shade300,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Create new task',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.deepPurple.shade300,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // WBS List
        Expanded(
          child: FutureBuilder<ProjectWbsResponse>(
            future: _futureWbs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        'Loading tasks...',
                        style: TextStyle(fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Error loading tasks',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${snapshot.error}',
                        style: const TextStyle(fontFamily: 'Montserrat'),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchWbsData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple.shade50,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                final tasks = snapshot.data!.data?.content ?? [];
                if (tasks.isEmpty) {
                  return const Center(
                    child: Text(
                      'No tasks found',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    final assignee =
                        task.assignees.isNotEmpty ? task.assignees.first : null;

                    return TaskListTile(
                      taskName: task.name ?? 'Unnamed Task',
                      taskCode: task.code,
                      startDate: task.startDate,
                      endDate: task.endDate,
                      description: task.description,
                      progressPercent: task.progressPercent ?? 0,
                      state: task.state ?? 'Unknown',
                      assigneeName: assignee?.fullName,
                      assigneeAvatar: assignee?.avatar,
                      onTap: () {
                        // TODO: Handle task tap
                      },
                    );
                  },
                );
              }
              return const Center(
                child: Text(
                  'No data available',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTaskDetailRow(String label, Widget value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        value,
      ],
    );
  }

  Color _getProgressColor(int progress) {
    if (progress >= 75) {
      return Colors.green;
    } else if (progress >= 50) {
      return Colors.blue;
    } else if (progress >= 25) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
