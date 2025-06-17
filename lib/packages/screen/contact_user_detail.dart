import 'package:clone_aom/l10n/app_localizations.dart';
import 'package:clone_aom/packages/models/employeeDetail_response.dart';
import 'package:clone_aom/packages/screen/contact_user_edit.dart';
import 'package:clone_aom/packages/services/contact_services.dart';
import 'package:flutter/material.dart';

import 'components/contact_user_tile.dart';

class ContactUserDetail extends StatefulWidget {
  final String name;
  final String code;
  final String company;
  final String phone;
  final String email;
  final bool isFemale;
  final int employeeId;

  const ContactUserDetail({
    super.key,
    required this.name,
    required this.code,
    required this.company,
    required this.phone,
    required this.email,
    required this.isFemale,
    required this.employeeId,
  });

  @override
  State<ContactUserDetail> createState() => _ContactUserDetailState();
}

class _ContactUserDetailState extends State<ContactUserDetail> {
  final EmployeeDetailApiServices _employeeDetailService =
      EmployeeDetailApiServices();
  late Future<EmployeeDetailResponse> _futureEmployeeDetail;

  @override
  void initState() {
    super.initState();
    _futureEmployeeDetail = _employeeDetailService.fetchEmployeeDetail(
      widget.employeeId,
    );
  }

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
      body: FutureBuilder<EmployeeDetailResponse>(
        future: _futureEmployeeDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading employee details...',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 60),
                  SizedBox(height: 16),
                  Text(
                    'Error loading employee details',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      snapshot.error.toString(),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _futureEmployeeDetail = _employeeDetailService
                            .fetchEmployeeDetail(widget.employeeId);
                      });
                    },
                    icon: Icon(Icons.refresh),
                    label: Text(
                      'Retry',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      backgroundColor: Colors.deepPurple.shade200,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final employeeData = snapshot.data!.data;
            final employeeDetail = employeeData.employee;
            final address = employeeData.employeeAddress.isNotEmpty
                ? employeeData.employeeAddress.first
                : null;
            return Stack(
              children: [
                // Main content
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildBasicInfoSection(context, employeeDetail),
                          _buildCitizenIdentificationSection(
                            context,
                            employeeData,
                          ),
                          _buildBankAccountSection(context, employeeData),
                          _buildHealthSection(context, employeeData),
                          _buildContactInfomationSection(
                            context,
                            employeeData,
                          ),
                          _buildFamilyInformationSection(context, employeeData),
                          _buildWorkExperienceSection(context, employeeData),
                          _buildCertificateSection(context, employeeData),
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
                        widget.isFemale
                            ? 'assets/images/female_avatar.png'
                            : 'assets/images/male_avatar.png',
                    name: widget.name,
                    company: '${widget.code} - ${widget.company}',
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text(
              'No data available',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
            ),
          );
        },
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
  Widget _buildBasicInfoSection(
    BuildContext context,
    EmployeeDetail employeeDetail,
  ) {
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
              Icons.badge,
              AppLocalizations.of(context)!.detailEmployee_attendanceCode,
              employeeDetail.code,
            ),
            _buildContactRow(
              Icons.numbers,
              AppLocalizations.of(context)!.detailEmployee_recordID,
              employeeDetail.id.toString(),
            ),
            _buildContactRow(
              Icons.person,
              AppLocalizations.of(context)!.detailEmployee_employeeName,
              employeeDetail.fullName,
            ),
            _buildContactRow(
              Icons.calendar_month_sharp,
              AppLocalizations.of(context)!.detailEmployee_birthDate,
              employeeDetail.birthDate,
            ),
            _buildContactRow(
              Icons.wc,
              AppLocalizations.of(context)!.detailEmployee_gender,
              employeeDetail.gender,
            ),
            _buildContactRow(
              Icons.location_city,
              AppLocalizations.of(context)!.detailEmployee_pob,
              employeeDetail.placeOfBirth ?? 'N/A',
            ),
            _buildContactRow(
              Icons.flag,
              AppLocalizations.of(context)!.detailEmployee_nationality,
              employeeDetail.nationality ?? 'N/A',
            ),
            _buildContactRow(
              Icons.groups,
              AppLocalizations.of(context)!.detailEmployee_ethnicGroup,
              employeeDetail.ethnicGroup ?? 'N/A',
            ),
            _buildContactRow(
              Icons.favorite,
              AppLocalizations.of(context)!.detailEmployee_maritalStatus,
              employeeDetail.maritalStatus ?? 'N/A',
            ),
            _buildContactRow(
              Icons.church,
              AppLocalizations.of(context)!.detailEmployee_religion,
              employeeDetail.religion ?? 'N/A',
            ),
            _buildContactRow(
              Icons.school,
              AppLocalizations.of(context)!.detailEmployee_highSchoolLevel,
              employeeDetail.highSchoolLevel ?? 'N/A',
            ),
            _buildContactRow(
              Icons.psychology,
              AppLocalizations.of(context)!.detailEmployee_specialization,
              employeeDetail.specialization ?? 'N/A',
            ),
            _buildContactRow(
              Icons.receipt_long,
              AppLocalizations.of(context)!.detailEmployee_personalTaxCode,
              employeeDetail.personalTaxCode ?? 'N/A',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfomationSection(
    BuildContext context,
    EmployeeDetailData data,
  ) {
    final employeeDetail = data.employee;
    final address = data.employeeAddress.isNotEmpty 
        ? data.employeeAddress.first 
        : null;

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
              Icons.phone,
              AppLocalizations.of(context)!.detailEmployee_phoneNumber,
              employeeDetail.mobile,
            ),
            _buildContactRow(
              Icons.email,
              AppLocalizations.of(context)!.detailEmployee_email,
              employeeDetail.email,
            ),
            _buildContactRow(
              Icons.home,
              AppLocalizations.of(context)!.detailEmployee_houseNumber,
              address?.addressDetail ?? 'N/A',
            ),
            _buildContactRow(
              Icons.location_on,
              AppLocalizations.of(context)!.detailEmployee_wardCity,
              '${address?.districtCode ?? 'N/A'} - ${address?.provinceCode ?? 'N/A'}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCitizenIdentificationSection(
    BuildContext context,
    EmployeeDetailData data,
  ) {
    final identity = data.identityEmployee;

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
                AppLocalizations.of(context)!.detailEmployee_citizenIdentificationInfo,
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
              Icons.credit_card,
              AppLocalizations.of(context)!.detailEmployee_citizenID,
              identity?.no ?? 'N/A',
            ),
            _buildContactRow(
              Icons.date_range,
              AppLocalizations.of(context)!.detailEmployee_issueDate,
              identity?.issueDate ?? 'N/A',
            ),
            _buildContactRow(
              Icons.place,
              AppLocalizations.of(context)!.detailEmployee_issuePlace,
              identity?.issuePlace ?? 'N/A',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankAccountSection(
    BuildContext context,
    EmployeeDetailData data,
  ) {
    final bank = data.employeeBank;

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
              Icons.account_balance,
              AppLocalizations.of(context)!.detailEmployee_bankName,
              bank?.bank ?? 'N/A',
            ),
            _buildContactRow(
              Icons.credit_card,
              AppLocalizations.of(context)!.detailEmployee_cardNumber,
              bank?.cardNumber ?? 'N/A',
            ),
            _buildContactRow(
              Icons.person,
              AppLocalizations.of(context)!.detailEmployee_accountName,
              bank?.accountName ?? 'N/A',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilyInformationSection(
    BuildContext context,
    EmployeeDetailData data,
  ) {
    final familyMembers = data.employeeDependent;

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
                AppLocalizations.of(context)!.detailEmployee_familyInfo,
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
            if (familyMembers.isEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'No family members found',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              )
            else
              ...familyMembers.map((member) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        _buildContactRow(
                          Icons.person,
                          AppLocalizations.of(context)!.detailEmployee_relativeName,
                          member.fullName,
                        ),
                        _buildContactRow(
                          Icons.phone,
                          AppLocalizations.of(context)!.detailEmployee_relativePhoneNumber,
                          member.phone ?? 'N/A',
                        ),
                        _buildContactRow(
                          Icons.family_restroom,
                          AppLocalizations.of(context)!.detailEmployee_relativeRelationship,
                          member.relationship ?? 'N/A',
                        ),
                        _buildContactRow(
                          Icons.badge,
                          AppLocalizations.of(context)!.detailEmployee_relativeCitizenID,
                          member.identityNo ?? 'N/A',
                        ),
                        _buildContactRow(
                          Icons.place,
                          AppLocalizations.of(context)!.detailEmployee_relativeIssuePlace,
                          member.issuePlace ?? 'N/A',
                        ),
                        _buildContactRow(
                          Icons.receipt,
                          AppLocalizations.of(context)!.detailEmployee_relativeTaxCode,
                          member.personalTaxCode ?? 'N/A',
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkExperienceSection(
    BuildContext context,
    EmployeeDetailData data,
  ) {
    final workExperiences = data.employeeWorkExp;

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
                AppLocalizations.of(context)!.detailEmployee_workExp,
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
            if (workExperiences.isEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'No work experience found',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              )
            else
              ...workExperiences.map((exp) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        _buildContactRow(
                          Icons.business,
                          AppLocalizations.of(context)!.detailEmployee_workExpCompany,
                          exp.company ?? 'N/A',
                        ),
                        _buildContactRow(
                          Icons.work,
                          AppLocalizations.of(context)!.detailEmployee_workExpRole,
                          exp.role ?? 'N/A',
                        ),
                        _buildContactRow(
                          Icons.date_range,
                          AppLocalizations.of(context)!.detailEmployee_workExpFrom,
                          exp.fromDate ?? 'N/A',
                        ),
                        _buildContactRow(
                          Icons.date_range,
                          AppLocalizations.of(context)!.detailEmployee_workExpTo,
                          exp.toDate ?? 'N/A',
                        ),
                        _buildContactRow(
                          Icons.note,
                          AppLocalizations.of(context)!.detailEmployee_workExp,
                          exp.reasonOff ?? 'N/A',
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificateSection(
    BuildContext context,
    EmployeeDetailData data,
  ) {
    final certificates = data.employeeCertificate;

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
                AppLocalizations.of(context)!.detailEmployee_cert,
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
            if (certificates.isEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'No certificates found',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              )
            else
              ...certificates.map((cert) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        _buildContactRow(
                          Icons.school,
                          AppLocalizations.of(context)!.detailEmployee_certName,
                          cert.name ?? 'N/A',
                        ),
                        _buildContactRow(
                          Icons.grade,
                          AppLocalizations.of(context)!.detailEmployee_certClass,
                          cert.classification ?? 'N/A',
                        ),
                        _buildContactRow(
                          Icons.date_range,
                          AppLocalizations.of(context)!.detailEmployee_certIssueDate,
                          cert.issueDate ?? 'N/A',
                        ),
                        _buildContactRow(
                          Icons.calendar_today,
                          AppLocalizations.of(context)!.detailEmployee_certYear,
                          cert.year ?? 'N/A',
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthSection(
    BuildContext context,
    EmployeeDetailData data,
  ) {
    final health = data.employeeHealthy;

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
              Icons.height,
              AppLocalizations.of(context)!.detailEmployee_height,
              health?.height ?? 'N/A',
            ),
            _buildContactRow(
              Icons.monitor_weight,
              AppLocalizations.of(context)!.detailEmployee_weight,
              health?.weight ?? 'N/A',
            ),
            _buildContactRow(
              Icons.bloodtype,
              AppLocalizations.of(context)!.detailEmployee_bloodType,
              health?.blood ?? 'N/A',
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
