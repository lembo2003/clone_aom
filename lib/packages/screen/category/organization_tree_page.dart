import 'package:clone_aom/packages/models/category/organization_response.dart';
import 'package:clone_aom/packages/services/category_services.dart';
import 'package:flutter/material.dart';
import 'package:graphview/graphview.dart';

class OrganizationTreePage extends StatefulWidget {
  const OrganizationTreePage({super.key});

  @override
  State<OrganizationTreePage> createState() => _OrganizationTreePageState();
}

class _OrganizationTreePageState extends State<OrganizationTreePage> {
  final CategoryApiServices _categoryService = CategoryApiServices();
  late Future<OrganizationResponse> _futureOrganizations;
  final Graph graph = Graph()..isTree = true;
  late BuchheimWalkerConfiguration builder;
  final Map<String, Node> nodeMap = {};
  // Special ID for our virtual root node
  static const String rootNodeId = 'department_root';

  @override
  void initState() {
    super.initState();
    _futureOrganizations = _categoryService.fetchOrg();
    builder = BuchheimWalkerConfiguration()
      ..siblingSeparation = 50
      ..levelSeparation = 100
      ..subtreeSeparation = 50
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  void _buildGraphFromOrganizations(List<Content> organizations) {
    // Clear existing graph
    graph.nodes.clear();
    graph.edges.clear();
    nodeMap.clear();

    // Create the virtual root node
    final rootNode = Node.Id(rootNodeId);
    nodeMap[rootNodeId] = rootNode;
    graph.addNode(rootNode);

    // Helper function to recursively process organizations and their children
    void processOrg(Content org) {
      // Create node if it doesn't exist
      if (!nodeMap.containsKey(org.id.toString())) {
        final node = Node.Id(org.id.toString());
        nodeMap[org.id.toString()] = node;
        graph.addNode(node);
      }

      // Process children if they exist
      if (org.children != null) {
        for (var child in org.children!) {
          // Create child node if it doesn't exist
          if (!nodeMap.containsKey(child.id.toString())) {
            final childNode = Node.Id(child.id.toString());
            nodeMap[child.id.toString()] = childNode;
            graph.addNode(childNode);
          }

          // Add edge from parent to child
          final parentNode = nodeMap[org.id.toString()];
          final childNode = nodeMap[child.id.toString()];
          if (parentNode != null && childNode != null) {
            graph.addEdge(parentNode, childNode);
          }

          // Recursively process the child's children
          processOrg(child);
        }
      }
    }

    // Process root organizations (those with null parentId)
    final rootOrgs = organizations.where((org) => org.parentId == null).toList();
    
    // First process all organizations
    for (var org in rootOrgs) {
      processOrg(org);
      // Connect root organizations to our virtual root node
      final orgNode = nodeMap[org.id.toString()];
      if (orgNode != null) {
        graph.addEdge(rootNode, orgNode);
      }
    }
  }

  Content? _findOrgById(List<Content> organizations, String id) {
    // Return virtual root node data if it's the department root
    if (id == rootNodeId) {
      return Content(
        id: -1,
        name: 'Department',
        code: 'DEPT',
        type: 'ROOT',
        state: 'ACTIVE',
        parentId: null,
        path: 'root',
        description: 'Virtual root node for department hierarchy',
        function: 'Organization management',
        task: 'Manage departments',
        managerId: null,
        children: [],
        employeeDto: null
      );
    }

    // First check in root organizations
    for (var org in organizations) {
      if (org.id.toString() == id) {
        return org;
      }
      // Then check in children
      if (org.children != null) {
        for (var child in org.children!) {
          if (child.id.toString() == id) {
            return child;
          }
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Organization Tree',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: FutureBuilder<OrganizationResponse>(
        future: _futureOrganizations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data?.data?.content == null) {
            return const Center(child: Text('No data available'));
          }

          final organizations = snapshot.data!.data!.content;
          _buildGraphFromOrganizations(organizations);

          return Container(
            color: Colors.grey.shade50,
            child: Center(
              child: InteractiveViewer(
                constrained: false,
                boundaryMargin: const EdgeInsets.all(20),
                minScale: 0.1,
                maxScale: 2.0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(
                      builder,
                      TreeEdgeRenderer(builder),
                    ),
                    paint: Paint()
                      ..color = Colors.deepPurple.shade200
                      ..strokeWidth = 2
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      final orgId = node.key?.value as String;
                      final org = _findOrgById(organizations, orgId);
                      
                      if (org == null) {
                        return Container();
                      }

                      // Special styling for root node
                      if (orgId == rootNodeId) {
                        return Container(
                          width: 180,
                          padding: const EdgeInsets.all(12.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.deepPurple.shade300,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.account_tree,
                                color: Colors.deepPurple,
                                size: 24,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Department',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return OrgNodeWidget(organization: org);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrgNodeWidget extends StatelessWidget {
  final Content organization;

  const OrgNodeWidget({
    super.key,
    required this.organization,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = organization.state?.toLowerCase() == 'active';
    
    return Container(
      width: 180,
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? Colors.green.shade400 : Colors.grey.shade400,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: (isActive ? Colors.green : Colors.grey).withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            organization.name ?? 'Untitled',
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            organization.code ?? 'No Code',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 8,
                color: isActive ? Colors.green : Colors.grey,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  organization.type ?? 'Unknown Type',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
