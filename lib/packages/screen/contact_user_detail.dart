import 'package:clone_aom/l10n/app_localizations.dart';
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
        title: Text(
          AppLocalizations.of(context)!.detailHomeLabel,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
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
                    _buildBasicInfoSection(context),
                    _buildCitizenIdentificationSection(context),
                    _buildBankAccountSection(context),
                    _buildHealthSection(context),
                    _buildContactInfomationSection(context),
                    _buildFamilyInformationSection(context),
                    _buildWorkExperienceSection(context),
                    _buildCertificateSection(context),
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
  Widget _buildBasicInfoSection(BuildContext context) {
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
              Text(
                AppLocalizations.of(context)!.detailEmployee_basicInformation,
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
              AppLocalizations.of(context)!.detailEmployee_attendanceCode,
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              AppLocalizations.of(context)!.detailEmployee_recordID,
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              AppLocalizations.of(context)!.detailEmployee_employeeName,
              'NULL',
            ),
            _buildContactRow(
              Icons.calendar_month_sharp,
              AppLocalizations.of(context)!.detailEmployee_birthDate,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_gender,
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              AppLocalizations.of(context)!.detailEmployee_pob,
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              AppLocalizations.of(context)!.detailEmployee_nationality,
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              AppLocalizations.of(context)!.detailEmployee_ethnicGroup,
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              AppLocalizations.of(context)!.detailEmployee_maritalStatus,
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              AppLocalizations.of(context)!.detailEmployee_religion,
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              AppLocalizations.of(context)!.detailEmployee_highSchoolLevel,
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              AppLocalizations.of(context)!.detailEmployee_specialization,
              'NULL',
            ),
            _buildContactRow(
              Icons.account_circle_rounded,
              AppLocalizations.of(context)!.detailEmployee_personalTaxCode,
              'NULL',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfomationSection(BuildContext context) {
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
              Text(
                AppLocalizations.of(context)!.detailEmployee_contactInfo,
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
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_phoneNumber,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_email,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_houseNumber,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_wardCity,
              'NULL',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCitizenIdentificationSection(BuildContext context) {
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
              Text(
                AppLocalizations.of(
                  context,
                )!.detailEmployee_citizenIdentificationInfo,
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
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_citizenID,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_issueDate,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_issuePlace,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_frontIdCard,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_backIdCard,
              'NULL',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankAccountSection(BuildContext context) {
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
              Text(
                AppLocalizations.of(context)!.detailEmployee_bankAccount,
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
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_bankName,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_cardNumber,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_accountName,
              'NULL',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilyInformationSection(BuildContext context) {
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

  Widget _buildWorkExperienceSection(BuildContext context) {
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

  Widget _buildCertificateSection(BuildContext context) {
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

  Widget _buildHealthSection(BuildContext context) {
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
              Text(
                AppLocalizations.of(context)!.detailEmployee_health,
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
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_height,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_weight,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_bloodType,
              'NULL',
            ),
            _buildContactRow(
              Icons.people_sharp,
              AppLocalizations.of(context)!.detailEmployee_attachment,
              'NULL',
            ),
          ],
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
