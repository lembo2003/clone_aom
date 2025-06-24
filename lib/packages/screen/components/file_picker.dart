import 'package:clone_aom/l10n/app_localizations.dart';
import 'package:clone_aom/packages/services/document_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerDialog extends StatefulWidget {
  final int folderId;
  final Function()? onUploadSuccess;

  const FilePickerDialog({
    Key? key,
    required this.folderId,
    this.onUploadSuccess,
  }) : super(key: key);

  @override
  _FilePickerDialogState createState() => _FilePickerDialogState();
}

class _FilePickerDialogState extends State<FilePickerDialog> {
  PlatformFile? selectedFile;
  bool isUploading = false;
  String? errorMessage;
  final DocumentServices _documentServices = DocumentServices();

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        withData: false,
        withReadStream: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedFile = result.files.single;
          errorMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error picking file: ${e.toString()}';
      });
    }
  }

  Future<void> uploadFile() async {
    if (selectedFile == null || selectedFile!.path == null) return;

    setState(() {
      isUploading = true;
      errorMessage = null;
    });

    try {
      await _documentServices.uploadFile(
        filePath: selectedFile!.path!,
        fileName: selectedFile!.name,
        folderId: widget.folderId,
      );

      if (mounted) {
        Navigator.of(context).pop();
        if (widget.onUploadSuccess != null) {
          widget.onUploadSuccess!();
        }
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(20),
        constraints: BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.documentPage_upload,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Selected file info
            if (selectedFile != null) ...[
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected File:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Name: ${selectedFile!.name}',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    Text(
                      'Size: ${(selectedFile!.size / 1024).toStringAsFixed(2)} KB',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    Text(
                      'Uploading to folder id: ${(widget.folderId)}',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],

            // Error message
            if (errorMessage != null) ...[
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red, fontFamily: 'Montserrat'),
                ),
              ),
              SizedBox(height: 20),
            ],

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isUploading ? null : pickFile,
                    icon: Icon(Icons.file_upload),
                    label: Text(
                      selectedFile == null ? 'Select File' : 'Change File',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                if (selectedFile != null) ...[
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isUploading ? null : uploadFile,
                      child:
                          isUploading
                              ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : Text(
                                'Upload',
                                style: TextStyle(fontFamily: 'Montserrat'),
                              ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
