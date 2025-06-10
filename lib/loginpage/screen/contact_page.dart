import 'package:clone_aom/loginpage/screen/components/main_menu.dart';
import 'package:clone_aom/loginpage/screen/contact_user_detail.dart';
import 'package:flutter/material.dart';

import 'components/contact_user_tile.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    'Contacts',
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
                            'All',
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
                            'Assigned to me',
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
                          hintText: 'Contacts',
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
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  ContactUserDetail(username: "ARAFI Zohra"),
                        ),
                      );
                    },
                    child: ContactUserTile(
                      name: "ARAFI Zohra",
                      code: "P0020",
                      company: "P0018 - BOURGEOIS INDUSTRIES",
                      address: "10 RUE DES ARCHIVES 94000 CRETEIL",
                      phone: "01.72.29.71.99",
                      email: "z.arafi@bourgeois-industries.fr",
                      isFemale: true,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  ContactUserDetail(username: "BLANC Bernard"),
                        ),
                      );
                    },
                    child: ContactUserTile(
                      name: "BLANC Bernard",
                      code: "P0007",
                      company: "P0005 - BLUEBERRY TELECOM",
                      address: "75 RUE MARCEL SEMBAT 13000 MARSEILLE",
                      phone: "04.32.13.60.99",
                      email: "b.blanc@blueberry-telecom.fr",
                      isFemale: false,
                    ),
                  ),
                  ContactUserTile(
                    name: "ARAFI Zohra",
                    code: "P0020",
                    company: "P0018 - BOURGEOIS INDUSTRIES",
                    address: "10 RUE DES ARCHIVES 94000 CRETEIL",
                    phone: "01.72.29.71.99",
                    email: "z.arafi@bourgeois-industries.fr",
                    isFemale: true,
                  ),
                  ContactUserTile(
                    name: "ARAFI Zohra",
                    code: "P0020",
                    company: "P0018 - BOURGEOIS INDUSTRIES",
                    address: "10 RUE DES ARCHIVES 94000 CRETEIL",
                    phone: "01.72.29.71.99",
                    email: "z.arafi@bourgeois-industries.fr",
                    isFemale: true,
                  ),
                  ContactUserTile(
                    name: "ARAFI Zohra",
                    code: "P0020",
                    company: "P0018 - BOURGEOIS INDUSTRIES",
                    address: "10 RUE DES ARCHIVES 94000 CRETEIL",
                    phone: "01.72.29.71.99",
                    email: "z.arafi@bourgeois-industries.fr",
                    isFemale: true,
                  ),
                  ContactUserTile(
                    name: "ARAFI Zohra",
                    code: "P0020",
                    company: "P0018 - BOURGEOIS INDUSTRIES",
                    address: "10 RUE DES ARCHIVES 94000 CRETEIL",
                    phone: "01.72.29.71.99",
                    email: "z.arafi@bourgeois-industries.fr",
                    isFemale: true,
                  ),
                  ContactUserTile(
                    name: "ARAFI Zohra",
                    code: "P0020",
                    company: "P0018 - BOURGEOIS INDUSTRIES",
                    address: "10 RUE DES ARCHIVES 94000 CRETEIL",
                    phone: "01.72.29.71.99",
                    email: "z.arafi@bourgeois-industries.fr",
                    isFemale: true,
                  ),
                  ContactUserTile(
                    name: "ARAFI Zohra",
                    code: "P0020",
                    company: "P0018 - BOURGEOIS INDUSTRIES",
                    address: "10 RUE DES ARCHIVES 94000 CRETEIL",
                    phone: "01.72.29.71.99",
                    email: "z.arafi@bourgeois-industries.fr",
                    isFemale: true,
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
