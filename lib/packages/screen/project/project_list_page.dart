import 'package:clone_aom/l10n/app_localizations.dart';
import 'package:clone_aom/packages/models/project/project_list_response.dart';
import 'package:clone_aom/packages/screen/components/main_menu.dart';
import 'package:clone_aom/packages/screen/components/project_list_tile.dart';
import 'package:clone_aom/packages/screen/project/project_detail_page.dart';
import 'package:clone_aom/packages/services/project_services.dart';
import 'package:flutter/material.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  final TextEditingController _searchController = TextEditingController();
  final ProjectApiServices _projectService = ProjectApiServices();

  Future<ProjectListResponse>? _futureProjects;

  @override
  void initState() {
    super.initState();
    _futureProjects = _projectService.fetchProjects();
    _searchController.addListener(() {
      setState(() {}); // Trigger rebuild when search text changes
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainMenu(),
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Builder(
                    builder:
                        (context) => IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.deepPurple,
                            size: 28,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.projectListPage_title,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(fontFamily: 'Montserrat'),
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(
                                context,
                              )!.projectListPage_search,
                          hintStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.search, color: Colors.grey, size: 24),
                    ),
                  ],
                ),
              ),
            ),
            // Project List
            Expanded(
              child: FutureBuilder<ProjectListResponse>(
                future: _futureProjects,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            'Loading projects...',
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
                            "Error loading projects",
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
                            onPressed: () {
                              setState(() {
                                _futureProjects =
                                    _projectService.fetchProjects();
                              });
                            },
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    final apiResponse = snapshot.data!;
                    if (apiResponse.success == true &&
                        apiResponse.data != null) {
                      final projects = apiResponse.data!.content;
                      final filteredProjects =
                          projects.where((project) {
                            final searchTerm =
                                _searchController.text.toLowerCase();
                            final projectName =
                                (project.name ?? '').toLowerCase();
                            final projectCode =
                                (project.code ?? '').toLowerCase();
                            return projectName.contains(searchTerm) ||
                                projectCode.contains(searchTerm);
                          }).toList();

                      if (filteredProjects.isEmpty) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "No projects found",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          setState(() {
                            _futureProjects = _projectService.fetchProjects();
                          });
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: filteredProjects.length,
                          itemBuilder: (context, index) {
                            final project = filteredProjects[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ProjectDetail(
                                          projectId: project.id,
                                        ),
                                  ),
                                );
                              },
                              child: ProjectListTile(
                                projectName: project.name ?? 'Untitled Project',
                                projectId: project.code ?? 'No ID',
                                endDate:
                                    project.endDate?.toString().split(' ')[0] ??
                                    'No date',
                                teamSize: (project.teamSize ?? 0).toString(),
                                progressPercent:
                                    (project.progressPercent ?? 0).toString(),
                                state: project.state ?? 'Unknown',
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          apiResponse.message ?? 'Unknown error',
                          style: const TextStyle(fontFamily: 'Montserrat'),
                        ),
                      );
                    }
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
        ),
      ),
    );
  }
}
