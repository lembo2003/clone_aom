import 'package:clone_aom/packages/screen/contact_user_edit.dart';
import 'package:flutter/material.dart';

import 'components/contact_user_tile.dart';

class ContactUserDetail extends StatelessWidget {
  final String name;
  final String code;
  final String company;
  final String phone;
  final String email;
  final bool isFemale;

  const ContactUserDetail({
    super.key,
    required this.name,
    required this.code,
    required this.company,
    required this.phone,
    required this.email,
    required this.isFemale,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.person_2, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.only(top: 60), // space for the user card
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Company tile (reuse ContactUserTile)
                    // Container(
                    //   margin: const EdgeInsets.symmetric(vertical: 8),
                    //   child: ContactUserTile(
                    //     name: name,
                    //     code: code,
                    //     company: company,
                    //     address: '',
                    //     phone: phone,
                    //     email: email,
                    //     isFemale: isFemale,
                    //   ),
                    // ),
                    // Custom expansion tiles
                    _buildBasicInfoSection(),
                    _buildCitizenIdentificationSection(),
                    _buildBankAccountSection(),
                    _buildFamilyInformationSection(),
                    _buildWorkExperienceSection(),
                    _buildCertificateSection(),
                    _buildHealthSection(),
                    _buildContactInfomationSection(),
                    _buildLinkedClientsSection(),
                  ],
                ),
              ),
            ),
          ),
          // User info card overlapping app bar
          Positioned(
            left: 0,
            right: 0,
            top: -10,
            child: _UserHeaderCard(
              avatar:
                  isFemale
                      ? 'assets/images/female_avatar.png'
                      : 'assets/images/male_avatar.png',
              name: name,
              company: '$code - $company',
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade200,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactUserEdit()),
          );
        },
        child: const Icon(Icons.edit, color: Colors.black, size: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Custom Contact Section
  Widget _buildBasicInfoSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Row(
            children: [
              const Text(
                'Basic information',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.expand_more, color: Colors.black),
          children: [
            _buildContactRow(
              Icons.account_circle_rounded,
              'Attendance Code',
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              'Profile Code',
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              'Employee Name',
              'NULL',
            ),
            _buildContactRow(Icons.calendar_month_sharp, 'Birth Date', 'NULL'),
            _buildContactRow(Icons.people_sharp, 'Gender', 'NULL'),
            _buildContactRow(
              Icons.account_circle_rounded,
              'Place of birth',
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              'Nationality',
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              'Ethnic Group',
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              'Marital Status',
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              'Nationality',
              'NULL',
            ),
            _buildContactRow(Icons.account_circle_rounded, 'Religion', 'NULL'),
            _buildContactRow(
              Icons.account_circle_rounded,
              'High School Level',
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              'Specialization',
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              'Personal Tax Code',
              'NULL',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfomationSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Row(
            children: [
              const Text(
                'Contact Information',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.expand_more, color: Colors.black),
          children: [
            _buildContactRow(Icons.phone, 'Phone number', '01.72.29.71.99'),
            _buildContactRow(
              Icons.smartphone,
              'Mobile phone',
              '06.43.52.92.99',
            ),
            _buildContactRow(
              Icons.email,
              'Mail address',
              'z.arafi@bourgeois-industries.fr',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCitizenIdentificationSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Row(
            children: [
              const Text(
                'Citizen Identification',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.expand_more, color: Colors.black),
          children: [],
        ),
      ),
    );
  }

  Widget _buildBankAccountSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Row(
            children: [
              const Text(
                'Bank Account',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.expand_more, color: Colors.black),
          children: [],
        ),
      ),
    );
  }

  Widget _buildFamilyInformationSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Row(
            children: [
              const Text(
                'Family Information',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.expand_more, color: Colors.black),
          children: [],
        ),
      ),
    );
  }

  Widget _buildWorkExperienceSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Row(
            children: [
              const Text(
                'Work Experiences',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.expand_more, color: Colors.black),
          children: [],
        ),
      ),
    );
  }

  Widget _buildCertificateSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Row(
            children: [
              const Text(
                'Certificate',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.expand_more, color: Colors.black),
          children: [],
        ),
      ),
    );
  }

  Widget _buildHealthSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Row(
            children: [
              const Text(
                'Health',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.expand_more, color: Colors.black),
          children: [],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                if (value.isNotEmpty)
                  Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
              ],
            ),
          ),
          if (value.isNotEmpty)
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.copy, size: 18, color: Colors.black45),
                  onPressed: () {},
                  tooltip: 'Copy',
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18, color: Colors.black45),
                  onPressed: () {},
                  tooltip: 'Edit',
                ),
              ],
            ),
        ],
      ),
    );
  }

  // Linked clients and/or prospects Section
  Widget _buildLinkedClientsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: const Text(
            'Linked clients and/or prospects',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          trailing: const Icon(Icons.expand_more, color: Colors.black),
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ContactUserTile(
                  name: 'BOURGEOIS INDUSTRIE',
                  code: 'P0018',
                  company: '',
                  address: '10 RUE DES ARCHIVES 94000 CRETEIL',
                  phone: '01.97.37.77.99',
                  email: 'info@bourgeois-industries.fr',
                  isFemale: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserHeaderCard extends StatelessWidget {
  final String avatar;
  final String name;
  final String company;
  const _UserHeaderCard({
    required this.avatar,
    required this.name,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(avatar),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.apartment,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          company,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
