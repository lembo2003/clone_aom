import 'package:flutter/material.dart';

class ContactUserEdit extends StatefulWidget {
  const ContactUserEdit({Key? key}) : super(key: key);

  @override
  State<ContactUserEdit> createState() => _ContactUserEditState();
}

class _ContactUserEditState extends State<ContactUserEdit>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String _civility = 'Ms.';
  String _firstName = 'Zohra';
  String _name = 'ARAFI';
  String _clientProspect = 'P0018 - BOURGEOIS INDUSTRIE';
  String _phone = '01.72.29.71.99';
  String _mobile = '06.43.52.92.99';
  String _mail = 'z.arafi@bourgeois-industries.fr';
  String _website = '';
  String _notes = '';

  // Edit/view mode toggle
  bool _isEditMode = false;
  // Show expanded actions in edit mode
  bool _showFabActions = false;

  // Civility options
  final List<String> _civilities = ['Ms.', 'Mr.'];

  // Client/Prospect options (placeholder)
  final List<String> _clientProspects = [
    'P0018 - BOURGEOIS INDUSTRIE',
    'P0022 - ESL Banking',
    'P0034 - DG Technologies',
    'P0036 - AZ Inno',
  ];

  void _openClientProspectDialog() async {
    if (!_isEditMode) return;
    final selected = await showDialog<String>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            height: 400,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Client / Prospect',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _clientProspects.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = _clientProspects[index];
                      return ListTile(
                        title: Text(item),
                        trailing: item == _clientProspect
                            ? const Icon(Icons.check, color: Colors.deepPurple)
                            : null,
                        onTap: () => Navigator.pop(context, item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (selected != null) {
      setState(() {
        _clientProspect = selected;
      });
    }
  }

  InputDecoration _inputDecoration({String? label, bool showLabel = true}) {
    return InputDecoration(
      labelText: showLabel ? label : null,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  BoxDecoration get _fieldBoxDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  Widget _buildField({
    required String label,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }

  Widget _buildViewField(String label, String value) {
    return _buildField(
      label: label,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: _fieldBoxDecoration,
        child: Text(
          value.isNotEmpty ? value : '-',
          style: const TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
        ),
      ),
    );
  }

  void _toggleEditMode() {
    setState(() {
      if (_isEditMode) {
        // If already in edit mode, pressing main FAB acts as cancel
        _isEditMode = false;
        _showFabActions = false;
      } else {
        _isEditMode = true;
        _showFabActions = true;
      }
    });
  }

  void _saveAndExitEditMode() {
    setState(() {
      _isEditMode = false;
      _showFabActions = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved!')),
    );
  }

  void _otherAction() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Other action!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Contact',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF7F7FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Civility
              _isEditMode
                  ? _buildField(
                      label: 'Civility',
                      child: Container(
                        decoration: _fieldBoxDecoration,
                        child: DropdownButtonFormField<String>(
                          value: _civility,
                          decoration: _inputDecoration(showLabel: false),
                          items: _civilities
                              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                              .toList(),
                          onChanged: _isEditMode
                              ? (val) => setState(() => _civility = val ?? _civility)
                              : null,
                          disabledHint: Text(_civility),
                        ),
                      ),
                    )
                  : _buildViewField('Civility', _civility),
              // First name
              _isEditMode
                  ? _buildField(
                      label: 'First name',
                      child: Container(
                        decoration: _fieldBoxDecoration,
                        child: TextFormField(
                          initialValue: _firstName,
                          enabled: _isEditMode,
                          decoration: _inputDecoration(showLabel: false),
                          onChanged: (val) => setState(() => _firstName = val),
                        ),
                      ),
                    )
                  : _buildViewField('First name', _firstName),
              // Name
              _isEditMode
                  ? _buildField(
                      label: 'Name',
                      child: Container(
                        decoration: _fieldBoxDecoration,
                        child: TextFormField(
                          initialValue: _name,
                          enabled: _isEditMode,
                          decoration: _inputDecoration(showLabel: false),
                          onChanged: (val) => setState(() => _name = val),
                        ),
                      ),
                    )
                  : _buildViewField('Name', _name),
              // Client / Prospect
              _isEditMode
                  ? _buildField(
                      label: 'Client / Prospect',
                      child: GestureDetector(
                        onTap: _openClientProspectDialog,
                        child: Container(
                          decoration: _fieldBoxDecoration,
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: TextEditingController(text: _clientProspect),
                              enabled: false,
                              decoration: _inputDecoration(showLabel: false).copyWith(
                                suffixIcon: const Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : _buildViewField('Client / Prospect', _clientProspect),
              // Phone number
              _isEditMode
                  ? _buildField(
                      label: 'Phone number',
                      child: Container(
                        decoration: _fieldBoxDecoration,
                        child: TextFormField(
                          initialValue: _phone,
                          enabled: _isEditMode,
                          decoration: _inputDecoration(showLabel: false),
                          keyboardType: TextInputType.phone,
                          onChanged: (val) => setState(() => _phone = val),
                        ),
                      ),
                    )
                  : _buildViewField('Phone number', _phone),
              // Mobile phone
              _isEditMode
                  ? _buildField(
                      label: 'Mobile phone',
                      child: Container(
                        decoration: _fieldBoxDecoration,
                        child: TextFormField(
                          initialValue: _mobile,
                          enabled: _isEditMode,
                          decoration: _inputDecoration(showLabel: false),
                          keyboardType: TextInputType.phone,
                          onChanged: (val) => setState(() => _mobile = val),
                        ),
                      ),
                    )
                  : _buildViewField('Mobile phone', _mobile),
              // Mail address
              _isEditMode
                  ? _buildField(
                      label: 'Mail address',
                      child: Container(
                        decoration: _fieldBoxDecoration,
                        child: TextFormField(
                          initialValue: _mail,
                          enabled: _isEditMode,
                          decoration: _inputDecoration(showLabel: false),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) => setState(() => _mail = val),
                        ),
                      ),
                    )
                  : _buildViewField('Mail address', _mail),
              // Web site
              _isEditMode
                  ? _buildField(
                      label: 'Web site',
                      child: Container(
                        decoration: _fieldBoxDecoration,
                        child: TextFormField(
                          initialValue: _website,
                          enabled: _isEditMode,
                          decoration: _inputDecoration(showLabel: false),
                          onChanged: (val) => setState(() => _website = val),
                        ),
                      ),
                    )
                  : _buildViewField('Web site', _website),
              // Notes
              _isEditMode
                  ? _buildField(
                      label: 'Notes',
                      child: Container(
                        decoration: _fieldBoxDecoration,
                        child: TextFormField(
                          initialValue: _notes,
                          enabled: _isEditMode,
                          decoration: _inputDecoration(showLabel: false),
                          maxLines: 3,
                          onChanged: (val) => setState(() => _notes = val),
                        ),
                      ),
                    )
                  : _buildViewField('Notes', _notes),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          if (_isEditMode && _showFabActions) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 120.0, right: 8),
              child: FloatingActionButton(
                heroTag: 'save',
                backgroundColor: Colors.green.shade200,
                onPressed: _saveAndExitEditMode,
                child: const Icon(Icons.save, color: Colors.black),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0, right: 8),
              child: FloatingActionButton(
                heroTag: 'other',
                backgroundColor: Colors.orange.shade200,
                onPressed: _otherAction,
                child: const Icon(Icons.diamond, color: Colors.black),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FloatingActionButton(
              backgroundColor: _isEditMode ? Colors.red.shade200 : Colors.deepPurple.shade200,
              onPressed: _toggleEditMode,
              child: Icon(_isEditMode ? Icons.close : Icons.edit, color: Colors.black, size: 32),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
