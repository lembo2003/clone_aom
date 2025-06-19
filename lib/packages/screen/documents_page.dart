import 'package:clone_aom/packages/screen/components/main_menu.dart';
import 'package:clone_aom/packages/services/document_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  bool _isGridView = false;
  String _currentPath = "Root";
  final TextEditingController _searchController = TextEditingController();
  final DocumentServices _documentServices = DocumentServices();

  // Storage usage variables
  final double _totalStorageGB = 1.0; // 1GB total
  final double _usedStorageGB = 0.56; // 560MB used

  // Current folder content
  List<FileItem> _currentFiles = [];
  List<FileItem> _filteredFiles = [];  // Add filtered files list
  bool _isLoading = true;
  String? _error;
  FileItem? _currentFolder; // Track current folder
  List<FileItem> _navigationStack = []; // Add navigation stack

  @override
  void initState() {
    super.initState();
    _loadCurrentFolder();
    _searchController.addListener(_handleSearch);  // Add search listener
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleSearch);
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredFiles = _currentFiles;
      } else {
        _filteredFiles = _currentFiles.where((file) {
          return file.name.toLowerCase().contains(query) ||
                 (file.pathFolder?.toLowerCase().contains(query) ?? false);
        }).toList();

        // Keep folders first in search results
        _filteredFiles.sort((a, b) {
          if (a.type == FileType.folder && b.type != FileType.folder) {
            return -1;
          } else if (a.type != FileType.folder && b.type == FileType.folder) {
            return 1;
          }
          return 0;
        });
      }
    });
  }

  Future<void> _loadCurrentFolder() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      List<FileItem> files;
      if (_currentFolder == null) {
        // Load root folders
        files = await _documentServices.fetchRootFolders();
        _currentPath = "Root";
      } else {
        // Load folder contents using the current folder's ID
        files = await _documentServices.fetchFolderContents(
          _currentFolder!.id!,
        );
        _currentPath = _currentFolder!.getDisplayPath();
      }

      setState(() {
        _currentFiles = files;
        _filteredFiles = files;  // Initialize filtered files
        _isLoading = false;
        // Clear search when loading new folder
        if (_searchController.text.isNotEmpty) {
          _searchController.clear();
        }
      });
    } catch (e) {
      print('Error in _loadCurrentFolder: $e'); // Debug log
      setState(() {
        _error = _formatErrorMessage(e.toString());
        _isLoading = false;
        _currentFiles = [];
        _filteredFiles = [];
      });
    }
  }

  String _formatErrorMessage(String error) {
    // Clean up the error message for display
    if (error.contains('SocketException') ||
        error.contains('Failed host lookup')) {
      return 'Network connection error.\nPlease check your internet connection and try again.';
    } else if (error.contains('Authentication failed')) {
      return 'Your session has expired.\nPlease log in again.';
    }
    // Remove Exception prefix if present
    return error.replaceAll('Exception: ', '');
  }

  void _navigateToFolder(FileItem folder) {
    setState(() {
      // Add current folder to navigation stack before moving to new folder
      if (_currentFolder != null) {
        _navigationStack.add(_currentFolder!);
      }
      _currentFolder = folder;
    });
    _loadCurrentFolder();
  }

  void _navigateBack() {
    setState(() {
      if (_navigationStack.isNotEmpty) {
        // Pop the last folder from navigation stack
        _currentFolder = _navigationStack.removeLast();
      } else {
        // If stack is empty, go back to root
        _currentFolder = null;
      }
    });
    _loadCurrentFolder();
  }

  void _showOptionsMenu(BuildContext context, FileItem file) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.drive_file_rename_outline,
                    color: Colors.blue,
                  ),
                  title: Text('Rename'),
                  onTap: () {
                    Navigator.pop(context);
                    // Handle rename
                  },
                ),
                if (file.type != FileType.folder) ...[
                  ListTile(
                    leading: Icon(Icons.download_rounded, color: Colors.blue),
                    title: Text('Download'),
                    onTap: () {
                      Navigator.pop(context);
                      // Handle download
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.share, color: Colors.blue),
                    title: Text('Share'),
                    onTap: () {
                      Navigator.pop(context);
                      // Handle share
                    },
                  ),
                ],
                ListTile(
                  leading: Icon(Icons.delete_outline, color: Colors.red),
                  title: Text('Delete', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    // Handle delete
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isRootFolder = _currentPath == "Root";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "File Manager",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(icon: Icon(Icons.refresh), onPressed: _loadCurrentFolder),
        ],
      ),
      drawer: MainMenu(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _currentPath,
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
          ),
          _buildStorageIndicator(),
          _buildActionButtons(),
          if (!isRootFolder) _buildBackNavigation(),
          Expanded(
            child:
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _error != null
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Error loading files',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _error!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadCurrentFolder,
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    )
                    : _filteredFiles.isEmpty
                    ? Center(
                      child: Text(
                        'No files in this folder',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    )
                    : _isGridView
                    ? _buildGridView()
                    : _buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle new folder/file creation
        },
        backgroundColor: Colors.purple[100],
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBackNavigation() {
    return InkWell(
      onTap: _navigateBack,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Icon(Icons.arrow_back, size: 20, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              'Back',
              style: TextStyle(
                color: Colors.blue,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
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
                decoration: InputDecoration(
                  hintText: 'Search files and folders...',
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
            if (_searchController.text.isNotEmpty)
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                },
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Icon(Icons.search, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorageIndicator() {
    final usedGB = _usedStorageGB.toStringAsFixed(2);
    final totalGB = _totalStorageGB.toStringAsFixed(2);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Storage',
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                '$usedGB GB / $totalGB GB',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _usedStorageGB / _totalStorageGB,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(Icons.upload_rounded, 'Upload', Colors.blue),
          _buildActionButton(
            Icons.create_new_folder_outlined,
            'New Folder',
            Colors.blue,
          ),
          _buildActionButton(Icons.download_rounded, 'Download', Colors.blue),
          _buildActionButton(Icons.delete_outline, 'Delete', Colors.blue),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontFamily: "Montserrat",
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _filteredFiles.length,  // Use filtered files
      itemBuilder: (context, index) {
        final file = _filteredFiles[index];  // Use filtered files
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getFileIcon(file.type),
                color: _getFileColor(file.type),
                size: 24,
              ),
            ),
            title: Text(
              file.name,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: file.type != FileType.folder
                ? Text(
                    '${file.size} • ${DateFormat('dd/MM/yyyy HH:mm').format(file.date)}',
                    style: TextStyle(fontSize: 12),
                  )
                : null,
            onTap: file.type == FileType.folder ? () => _navigateToFolder(file) : null,
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => _showOptionsMenu(context, file),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredFiles.length,  // Use filtered files
      itemBuilder: (context, index) {
        final file = _filteredFiles[index];  // Use filtered files
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: file.type == FileType.folder ? () => _navigateToFolder(file) : null,
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getFileIcon(file.type),
                        color: _getFileColor(file.type),
                        size: 32,
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        file.name,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (file.type != FileType.folder) ...[
                      SizedBox(height: 4),
                      Text(
                        file.size,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ],
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: Icon(Icons.more_vert, size: 20),
                    onPressed: () => _showOptionsMenu(context, file),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getFileIcon(FileType type) {
    switch (type) {
      case FileType.folder:
        return Icons.folder;
      case FileType.document:
        return Icons.description_outlined;
      case FileType.image:
        return Icons.image_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  Color _getFileColor(FileType type) {
    switch (type) {
      case FileType.folder:
        return Colors.blue;
      case FileType.document:
        return Colors.orange;
      case FileType.image:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
