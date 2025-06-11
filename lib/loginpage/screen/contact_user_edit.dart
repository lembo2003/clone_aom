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

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Text(
          value.isNotEmpty ? value : '-',
          style: const TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
        ),
      ),
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
                      child: DropdownButtonFormField<String>(
                        value: _civility,
                        decoration: _inputDecoration('Civility'),
                        items: _civilities
                            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                            .toList(),
                        onChanged: _isEditMode
                            ? (val) => setState(() => _civility = val ?? _civility)
                            : null,
                        disabledHint: Text(_civility),
                      ),
                    )
                  : _buildViewField('Civility', _civility),
              // First name
              _isEditMode
                  ? _buildField(
                      label: 'First name',
                      child: TextFormField(
                        initialValue: _firstName,
                        enabled: _isEditMode,
                        decoration: _inputDecoration('First name'),
                        onChanged: (val) => setState(() => _firstName = val),
                      ),
                    )
                  : _buildViewField('First name', _firstName),
              // Name
              _isEditMode
                  ? _buildField(
                      label: 'Name',
                      child: TextFormField(
                        initialValue: _name,
                        enabled: _isEditMode,
                        decoration: _inputDecoration('Name'),
                        onChanged: (val) => setState(() => _name = val),
                      ),
                    )
                  : _buildViewField('Name', _name),
              // Client / Prospect
              _isEditMode
                  ? _buildField(
                      label: 'Client / Prospect',
                      child: GestureDetector(
                        onTap: _openClientProspectDialog,
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: TextEditingController(text: _clientProspect),
                            enabled: false,
                            decoration: _inputDecoration('Client / Prospect').copyWith(
                              suffixIcon: const Icon(Icons.search),
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
                      child: TextFormField(
                        initialValue: _phone,
                        enabled: _isEditMode,
                        decoration: _inputDecoration('Phone number'),
                        keyboardType: TextInputType.phone,
                        onChanged: (val) => setState(() => _phone = val),
                      ),
                    )
                  : _buildViewField('Phone number', _phone),
              // Mobile phone
              _isEditMode
                  ? _buildField(
                      label: 'Mobile phone',
                      child: TextFormField(
                        initialValue: _mobile,
                        enabled: _isEditMode,
                        decoration: _inputDecoration('Mobile phone'),
                        keyboardType: TextInputType.phone,
                        onChanged: (val) => setState(() => _mobile = val),
                      ),
                    )
                  : _buildViewField('Mobile phone', _mobile),
              // Mail address
              _isEditMode
                  ? _buildField(
                      label: 'Mail address',
                      child: TextFormField(
                        initialValue: _mail,
                        enabled: _isEditMode,
                        decoration: _inputDecoration('Mail address'),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) => setState(() => _mail = val),
                      ),
                    )
                  : _buildViewField('Mail address', _mail),
              // Web site
              _isEditMode
                  ? _buildField(
                      label: 'Web site',
                      child: TextFormField(
                        initialValue: _website,
                        enabled: _isEditMode,
                        decoration: _inputDecoration('Web site'),
                        onChanged: (val) => setState(() => _website = val),
                      ),
                    )
                  : _buildViewField('Web site', _website),
              // Notes
              _isEditMode
                  ? _buildField(
                      label: 'Notes',
                      child: TextFormField(
                        initialValue: _notes,
                        enabled: _isEditMode,
                        decoration: _inputDecoration('Notes'),
                        maxLines: 3,
                        onChanged: (val) => setState(() => _notes = val),
                      ),
                    )
                  : _buildViewField('Notes', _notes),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isEditMode ? Colors.green.shade200 : Colors.deepPurple.shade200,
        onPressed: () {
          setState(() {
            _isEditMode = !_isEditMode;
          });
          if (!_isEditMode) {
            // Optionally save changes here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Saved!')),
            );
          }
        },
        child: Icon(_isEditMode ? Icons.save : Icons.edit, color: Colors.black, size: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
