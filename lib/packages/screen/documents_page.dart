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
  String _currentPath = "attachment";
  final TextEditingController _searchController = TextEditingController();

  // Storage usage variables
  final double _totalStorageGB = 1.0; // 1GB total
  final double _usedStorageGB = 0.54; // 540MB used

  // Current folder content - initialize with empty list
  List<FileItem> _currentFiles = [];

  // All files and folders structure
  late final Map<String, List<FileItem>> _folderContents;

  @override
  void initState() {
    super.initState();
    _folderContents = DocumentServices.getInitialFolderContents();
    _currentFiles = _folderContents[_currentPath] ?? [];
  }

  void _navigateToFolder(String path) {
    if (_folderContents.containsKey(path)) {
      setState(() {
        _currentPath = path;
        _currentFiles = _folderContents[path]!;
      });
    }
  }

  void _navigateBack() {
    if (_currentPath != "attachment") {
      final parentPath = _currentPath.substring(
        0,
        _currentPath.lastIndexOf('/'),
      );
      _navigateToFolder(parentPath);
    }
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
    final bool isRootFolder = _currentPath == "attachment";

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
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show menu
            },
          ),
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
                _currentFiles.isEmpty
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
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search files...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
      itemCount: _currentFiles.length,
      itemBuilder: (context, index) {
        final file = _currentFiles[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
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
            subtitle: Text(
              file.type == FileType.folder
                  ? '${file.itemCount} items'
                  : '${file.size} • ${DateFormat('dd/MM/yyyy HH:mm').format(file.date)}',
              style: TextStyle(fontSize: 12),
            ),
            onTap:
                file.type == FileType.folder
                    ? () => _navigateToFolder(file.path)
                    : null,
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
      itemCount: _currentFiles.length,
      itemBuilder: (context, index) {
        final file = _currentFiles[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap:
                file.type == FileType.folder
                    ? () => _navigateToFolder(file.path)
                    : null,
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
                    SizedBox(height: 4),
                    Text(
                      file.type == FileType.folder
                          ? '${file.itemCount} items'
                          : file.size,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
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
