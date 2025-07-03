// import 'dart:convert';

import 'package:clone_aom/packages/models/project/project_resources_response.dart';
import 'package:clone_aom/packages/screen/components/project/resource_list_tile.dart';
import 'package:clone_aom/packages/services/project_services.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class ProjectResourcesPage extends StatefulWidget {
  final int? projectId;

  const ProjectResourcesPage({super.key, required this.projectId});

  @override
  State<ProjectResourcesPage> createState() => _ProjectResourcesPageState();
}

class _ProjectResourcesPageState extends State<ProjectResourcesPage> {
  final ProjectApiServices _projectService = ProjectApiServices();
  final TextEditingController _searchController = TextEditingController();
  Future<ProjectResourcesResponse>? _futureResources;

  // ImageProvider? _getAvatarImage(String? base64String) {
  //   if (base64String == null || base64String.isEmpty) return null;
  //   try {
  //     // Remove data:image/xyz;base64, prefix if present
  //     final cleanBase64 =
  //         base64String.contains(',')
  //             ? base64String.split(',')[1]
  //             : base64String;
  //     return MemoryImage(base64Decode(cleanBase64));
  //   } catch (e) {
  //     debugPrint('Error decoding base64 image: $e');
  //     return null;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    print('ProjectResourcesPage initState - projectId: ${widget.projectId}');
    if (widget.projectId != null) {
      _futureResources = _projectService.fetchResourcesList(widget.projectId!);
    }
    _searchController.addListener(() {
      setState(() {}); // Trigger rebuild when search text changes
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshResources() async {
    print('Refreshing resources for projectId: ${widget.projectId}');
    setState(() {
      if (widget.projectId != null) {
        _futureResources = _projectService.fetchResourcesList(
          widget.projectId!,
        );
      }
    });
  }

  List<Datum> _filterResources(List<Datum> resources) {
    final searchTerm = _searchController.text.toLowerCase();
    if (searchTerm.isEmpty) return resources;

    return resources.where((resource) {
      final fullName = resource.humanResourceDto?.fullName?.toLowerCase() ?? '';
      final position = resource.position?.toLowerCase() ?? '';
      final email = resource.humanResourceDto?.email?.toLowerCase() ?? '';

      return fullName.contains(searchTerm) ||
          position.contains(searchTerm) ||
          email.contains(searchTerm);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                          )!.projectDetail_resources_search,
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
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
        // Resources List
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshResources,
            child: FutureBuilder<ProjectResourcesResponse>(
              future: _futureResources,
              builder: (context, snapshot) {
                print('FutureBuilder state: ${snapshot.connectionState}');
                if (snapshot.hasData)
                  print(
                    'Response data: ${snapshot.data?.data.length} resources',
                  );
                if (snapshot.hasError)
                  print('Error in FutureBuilder: ${snapshot.error}');

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          'Loading resources...',
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
                          "Error loading resources",
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
                          onPressed: _refreshResources,
                          child: const Text(
                            "Retry",
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  final filteredResources = _filterResources(
                    snapshot.data!.data,
                  );

                  if (filteredResources.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "No resources found",
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

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredResources.length,
                    itemBuilder: (context, index) {
                      final resource = filteredResources[index];
                      final humanResource = resource.humanResourceDto;

                      return ResourceListTile(
                        fullName: humanResource?.fullName,
                        position: resource.position,
                        email: humanResource?.email,
                        avatar: humanResource?.avatar,
                        onTap: () {
                          // TODO: Implement resource detail view
                        },
                        onActionPressed: () {
                          // TODO: Implement resource actions
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
        ),
      ],
    );
  }
}
