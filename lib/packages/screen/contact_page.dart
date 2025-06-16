import 'package:clone_aom/l10n/app_localizations.dart';
import 'package:clone_aom/packages/models/employee_response.dart';
import 'package:clone_aom/packages/screen/components/contact_user_tile_from_json.dart';
import 'package:clone_aom/packages/screen/components/main_menu.dart';
import 'package:clone_aom/packages/screen/contact_user_detail.dart';
import 'package:clone_aom/packages/services/contact_services.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();
  final EmployeeApiServices _employeeService = EmployeeApiServices();

  //LIST OF CONTACT - API
  late Future<EmployeeResponse> _futureEmployee;

  @override
  void initState() {
    super.initState();
    _futureEmployee = _employeeService.fetchEmployees();
    _searchController.addListener(() {
      setState(() {}); // Trigger rebuild when search text changes
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      drawer: MainMenu(),
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Builder(
                    builder:
                        (context) => IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.deepPurple,
                            size: 28,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    localization!.employeeList,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Segmented Control
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 0),
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color:
                                _selectedTab == 0
                                    ? Colors.deepPurple.shade200
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            localization.all,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color:
                                  _selectedTab == 0
                                      ? Colors.black
                                      : Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 1),
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color:
                                _selectedTab == 1
                                    ? Colors.deepPurple.shade200
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            localization.assignedToMe,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color:
                                  _selectedTab == 1
                                      ? Colors.black
                                      : Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Search Bar
            Padding(
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
                        style: TextStyle(fontFamily: 'Montserrat'),
                        decoration: InputDecoration(
                          hintText: localization.employeeList,
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.search, color: Colors.grey, size: 24),
                    ),
                  ],
                ),
              ),
            ),
            // The rest of the page (contacts list, etc.)
            Expanded(
              child: FutureBuilder<EmployeeResponse>(
                future: _futureEmployee,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            'Loading contacts...',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Error loading contacts",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${snapshot.error}',
                            style: TextStyle(fontFamily: 'Montserrat'),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _futureEmployee =
                                    _employeeService.fetchEmployees();
                              });
                            },
                            child: Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final apiResponse = snapshot.data!;
                    if (apiResponse.success) {
                      final employees = apiResponse.data.content;
                      final filteredEmployees =
                          employees.where((employee) {
                            final searchTerm =
                                _searchController.text.toLowerCase();
                            return employee.fullName.toLowerCase().contains(
                                  searchTerm,
                                ) ||
                                employee.code.toLowerCase().contains(
                                  searchTerm,
                                ) ||
                                employee.email.toLowerCase().contains(
                                  searchTerm,
                                ) ||
                                employee.mobile.toLowerCase().contains(
                                  searchTerm,
                                );
                          }).toList();

                      if (filteredEmployees.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "No contacts found",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          setState(() {
                            _futureEmployee = _employeeService.fetchEmployees();
                          });
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          itemCount: filteredEmployees.length,
                          itemBuilder: (context, index) {
                            final employee = filteredEmployees[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ContactUserDetail(
                                          name: employee.fullName,
                                          code: employee.code,
                                          company:
                                              employee
                                                  .department
                                                  .organization
                                                  .name,
                                          phone: employee.mobile,
                                          email: employee.email,
                                          isFemale:
                                              employee.gender.toLowerCase() ==
                                              'female',
                                          employeeId: employee.id,
                                        ),
                                  ),
                                );
                              },
                              child: ContactUserTileFromJson(
                                name: employee.fullName,
                                code: employee.code,
                                company: employee.department.organization.name,
                                birthday: employee.birthDate,
                                phone: employee.mobile,
                                email: employee.email,
                                isFemale:
                                    employee.gender.toLowerCase() == 'female',
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          apiResponse.message,
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                      );
                    }
                  }
                  return Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
