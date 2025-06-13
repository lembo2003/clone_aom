import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class PDFTestPage extends StatefulWidget {
  const PDFTestPage({super.key});

  @override
  _PDFTestPageState createState() => _PDFTestPageState();
}

class _PDFTestPageState extends State<PDFTestPage> {
  String? selectedFilePath;
  bool isLoading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF TEST PAGE"),
        actions: [
          IconButton(
            icon: Icon(Icons.folder_open),
            onPressed: pickPDFFile,
            tooltip: 'Pick PDF File',
          ),
          if (selectedFilePath != null)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: clearSelectedFile,
              tooltip: 'Clear File',
            ),
        ],
      ),
      body: Column(
        children: [
          // File picker button
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: isLoading ? null : pickPDFFile,
                  icon: Icon(Icons.file_upload),
                  label: Text(
                    selectedFilePath == null
                        ? 'Pick PDF from Device'
                        : 'Pick Different PDF',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tip: In file picker, choose "Internal storage" instead of Google Drive',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Loading indicator
          if (isLoading)
            Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),

          // Error message
          if (errorMessage != null)
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border.all(color: Colors.red.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                errorMessage!,
                style: TextStyle(color: Colors.red.shade700),
              ),
            ),

          // Current file info
          if (selectedFilePath != null)
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Viewing: ${selectedFilePath!.split('/').last}',
                style: TextStyle(color: Colors.green.shade700),
              ),
            ),

          // PDF Viewer
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _buildPDFViewer(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPDFViewer() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Failed to load PDF', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  errorMessage = null;
                });
                if (selectedFilePath != null) {
                  // Retry loading the selected file
                  _loadSelectedFile();
                }
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    // Show selected file or default asset
    if (selectedFilePath != null) {
      return PdfViewer.file(selectedFilePath!);
    } else {
      return PdfViewer.asset('assets/pdf/hey.pdf');
    }
  }

  Future<void> pickPDFFile() async {
    // Show guidance dialog first
    bool? shouldProceed = await _showFilePickerGuidance();
    if (shouldProceed != true) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
        allowCompression: false,
        withData: false,
        withReadStream: false,
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;

        // Validate if it's a valid PDF (basic check)
        if (await _isValidPDF(filePath)) {
          setState(() {
            selectedFilePath = filePath;
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Selected file is not a valid PDF';
            isLoading = false;
          });
        }
      } else {
        // User canceled the picker
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error picking file: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  Future<bool> _isValidPDF(String filePath) async {
    try {
      // Basic validation - check if file exists and has .pdf extension
      final file = File(filePath);
      if (!await file.exists()) return false;

      // Check file size (should not be empty)
      final fileSize = await file.length();
      if (fileSize == 0) return false;

      // You can add more sophisticated PDF validation here if needed
      return true;
    } catch (e) {
      return false;
    }
  }

  void _loadSelectedFile() {
    if (selectedFilePath != null) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // Simulate loading delay (pdfrx handles loading internally)
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  Future<bool?> _showFilePickerGuidance() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select PDF File'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('To select a PDF from your device:'),
              SizedBox(height: 8),
              Text('• Tap the menu (≡) icon in the file picker'),
              Text('• Choose "Internal storage" or "Device storage"'),
              Text('• Navigate to Downloads, Documents, or your PDF location'),
              SizedBox(height: 8),
              Text(
                'Avoid selecting from Google Drive unless you want cloud files.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Got it, Open Picker'),
            ),
          ],
        );
      },
    );
  }

  void clearSelectedFile() {
    setState(() {
      selectedFilePath = null;
      errorMessage = null;
    });
  }
}
