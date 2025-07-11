import 'package:clone_aom/l10n/app_localizations.dart';
import 'package:clone_aom/packages/models/category/organization_response.dart';
import 'package:clone_aom/packages/screen/category/organization_tree_page.dart';
import 'package:clone_aom/packages/screen/components/category/organization_list_tile.dart';
import 'package:clone_aom/packages/screen/components/main_menu.dart';
import 'package:clone_aom/packages/services/category_services.dart';
import 'package:flutter/material.dart';

class OrganizationListPage extends StatefulWidget {
  const OrganizationListPage({super.key});

  @override
  State<OrganizationListPage> createState() => _OrganizationListPageState();
}

class _OrganizationListPageState extends State<OrganizationListPage> {
  final TextEditingController _searchController = TextEditingController();
  final CategoryApiServices _categoryService = CategoryApiServices();
  final Set<String> _expandedNodes = {}; // Track expanded nodes by ID

  Future<OrganizationResponse>? _futureOrganizations;

  @override
  void initState() {
    super.initState();
    _futureOrganizations = _categoryService.fetchOrg();
    _searchController.addListener(() {
      setState(() {}); // Trigger rebuild when search text changes
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleNode(String nodeId) {
    setState(() {
      if (_expandedNodes.contains(nodeId)) {
        _expandedNodes.remove(nodeId);
      } else {
        _expandedNodes.add(nodeId);
      }
    });
  }

  // Recursive function to build organization tree items
  List<Widget> _buildOrganizationTree(
    List<Content> organizations, {
    double indentation = 0,
  }) {
    List<Widget> widgets = [];

    for (var org in organizations) {
      // Check if this org matches search criteria
      final searchTerm = _searchController.text.toLowerCase();
      final orgName = (org.name ?? '').toLowerCase();
      final orgCode = (org.code ?? '').toLowerCase();
      final matchesSearch =
          searchTerm.isEmpty ||
          orgName.contains(searchTerm) ||
          orgCode.contains(searchTerm);

      final hasChildren = org.children != null && org.children!.isNotEmpty;
      final isExpanded = _expandedNodes.contains(org.id.toString());

      if (matchesSearch) {
        widgets.add(
          Padding(
            padding: EdgeInsets.only(left: indentation),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      if (indentation > 0)
                        Container(
                          width: 24,
                          height: 24,
                          margin: const EdgeInsets.only(right: 8),
                          child: const Icon(
                            Icons.subdirectory_arrow_right,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      if (hasChildren)
                        Container(
                          width: 24,
                          height: 24,
                          margin: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              isExpanded ? Icons.remove_circle : Icons.add_circle,
                              size: 20,
                              color: Colors.deepPurple,
                            ),
                            onPressed: () => _toggleNode(org.id.toString()),
                          ),
                        ),
                      Expanded(
                        child: OrganizationListTile(
                          code: org.code ?? 'N/A',
                          name: org.name ?? 'Untitled Organization',
                          type: org.type ?? 'Unknown',
                          status: org.state ?? 'Unknown',
                          manager: org.employeeDto?.fullName ?? 'No Manager',
                          childCount: hasChildren ? org.children!.length : null,
                          onTap: () {
                            // TODO: Navigate to organization detail page
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }

      // Recursively add children with increased indentation if expanded
      if (matchesSearch && hasChildren && isExpanded) {
        widgets.addAll(
          _buildOrganizationTree(
            org.children!,
            indentation: indentation + 32, // Increase indentation for children
          ),
        );
      }
    }

    return widgets;
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
                    builder: (context) => IconButton(
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
                    AppLocalizations.of(context)!.organizationList_title,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.account_tree_rounded,
                        color: Colors.deepPurple,
                      ),
                      tooltip: 'Switch to Tree View',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrganizationTreePage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
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
                          hintText: AppLocalizations.of(context)!.organizationList_search,
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
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.search, color: Colors.grey, size: 24),
                    ),
                  ],
                ),
              ),
            ),
            // Organization List
            Expanded(
              child: Container(
                color: Colors.grey.shade50,
                child: FutureBuilder<OrganizationResponse>(
                  future: _futureOrganizations,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text(
                              'Loading organizations...',
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
                              "Error loading organizations",
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
                                  _futureOrganizations = _categoryService.fetchOrg();
                                });
                              },
                              child: const Text("Retry"),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      final apiResponse = snapshot.data!;
                      if (apiResponse.success == true && apiResponse.data != null) {
                        final organizations = apiResponse.data!.content;

                        // Filter root level organizations (those with null parentId)
                        final rootOrganizations = organizations
                            .where((org) => org.parentId == null)
                            .toList();

                        // Build tree structure
                        final treeWidgets = _buildOrganizationTree(rootOrganizations);

                        if (treeWidgets.isEmpty) {
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
                                  "No organizations found",
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
                              _futureOrganizations = _categoryService.fetchOrg();
                            });
                          },
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            children: treeWidgets,
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
            ),
          ],
        ),
      ),
    );
  }
}
