import 'package:clone_aom/l10n/app_localizations.dart';
import 'package:clone_aom/packages/models/project/project_overview_response.dart';
import 'package:clone_aom/packages/services/project_services.dart';
import 'package:flutter/material.dart';

class ProjectOverviewPage extends StatefulWidget {
  final int? projectId;

  const ProjectOverviewPage({super.key, required this.projectId});

  @override
  State<ProjectOverviewPage> createState() => _ProjectOverviewPageState();
}

class _ProjectOverviewPageState extends State<ProjectOverviewPage> {
  final ProjectApiServices _projectService = ProjectApiServices();
  Future<ProjectOverviewResponse>? _futureProjectOverview;

  @override
  void initState() {
    super.initState();
    _fetchProjectOverview();
  }

  void _fetchProjectOverview() {
    if (widget.projectId != null) {
      _futureProjectOverview = _projectService.fetchProjectOverview(
        widget.projectId!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProjectOverviewResponse>(
      future: _futureProjectOverview,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  'Loading project details...',
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
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Error loading project details',
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
                  onPressed: _fetchProjectOverview,
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
        } else if (snapshot.hasData && snapshot.data?.data != null) {
          final projectData = snapshot.data!.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Name Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.projectDetail_overview_name,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        projectData.name ?? 'Unnamed Project',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (projectData.code != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Code: ${projectData.code}',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Project Description Section
                _buildSection(
                  title:
                      AppLocalizations.of(
                        context,
                      )!.projectDetail_overview_description,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      projectData.description ?? 'No description available',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Project Status Section
                _buildSection(
                  title:
                      AppLocalizations.of(
                        context,
                      )!.projectDetail_overview_status,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildStatusRow(
                          AppLocalizations.of(
                            context,
                          )!.projectDetail_overview_statuslabel,
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(projectData.state),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              projectData.state ?? 'Unknown',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildStatusRow(
                          AppLocalizations.of(
                            context,
                          )!.projectDetail_overview_startDate,
                          Text(
                            projectData.startDate?.toString() ?? '--',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildStatusRow(
                          AppLocalizations.of(
                            context,
                          )!.projectDetail_overview_endDate,
                          Text(
                            projectData.endDate?.toString().split(' ')[0] ??
                                '--',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildStatusRow(
                          AppLocalizations.of(
                            context,
                          )!.projectDetail_overview_teamSize,
                          Text(
                            '${projectData.teamSize ?? 0} ${AppLocalizations.of(context)!.projectDetail_overview_members}',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Progress Section
                _buildSection(
                  title:
                      AppLocalizations.of(
                        context,
                      )!.projectDetail_overview_projectProgress,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.projectDetail_overview_overallProgress,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${projectData.progressPercent ?? 0}%',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: (projectData.progressPercent ?? 0) / 100,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getProgressColor(
                                projectData.progressPercent ?? 0,
                              ),
                            ),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: Text(
            'No data available',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        );
      },
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildStatusRow(String label, Widget value) {
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

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'in_progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'delayed':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
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
