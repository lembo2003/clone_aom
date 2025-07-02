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
  
  // Add controllers and state variables
  final TransformationController _transformationController = TransformationController();
  bool _isVerticalLayout = true;
  double _currentScale = 1.0;
  static const double _minScale = 0.3;
  static const double _maxScale = 2.0;
  static const double _scaleChange = 0.1;

  @override
  void initState() {
    super.initState();
    _futureOrganizations = _categoryService.fetchOrg();
    _initBuilder();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _initBuilder() {
    builder = BuchheimWalkerConfiguration()
      ..siblingSeparation = 50
      ..levelSeparation = 100
      ..subtreeSeparation = 50
      ..orientation = _isVerticalLayout
          ? BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM
          : BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT;
  }

  void _toggleOrientation() {
    setState(() {
      _isVerticalLayout = !_isVerticalLayout;
      _initBuilder();
    });
  }

  void _handleZoom(double scale) {
    final newScale = _currentScale + scale;
    if (newScale >= _minScale && newScale <= _maxScale) {
      setState(() {
        _currentScale = newScale;
        final Matrix4 matrix = Matrix4.identity()
          ..scale(_currentScale, _currentScale, 1.0);
        _transformationController.value = matrix;
      });
    }
  }

  void _resetZoom() {
    setState(() {
      _currentScale = 1.0;
      _transformationController.value = Matrix4.identity();
    });
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
        actions: [
          // Orientation toggle button
          IconButton(
            icon: Icon(
              _isVerticalLayout ? Icons.swap_horiz : Icons.swap_vert,
              color: Colors.deepPurple,
            ),
            onPressed: _toggleOrientation,
            tooltip: 'Toggle Layout',
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<OrganizationResponse>(
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
                    transformationController: _transformationController,
                    constrained: false,
                    boundaryMargin: const EdgeInsets.all(20),
                    minScale: _minScale,
                    maxScale: _maxScale,
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
          // Zoom controls overlay
          Positioned(
            right: 16,
            bottom: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: 'zoomIn',
                  mini: true,
                  onPressed: () => _handleZoom(_scaleChange),
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.add, color: Colors.deepPurple),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'zoomReset',
                  mini: true,
                  onPressed: _resetZoom,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.refresh, color: Colors.deepPurple),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'zoomOut',
                  mini: true,
                  onPressed: () => _handleZoom(-_scaleChange),
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.remove, color: Colors.deepPurple),
                ),
              ],
            ),
          ),
        ],
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
