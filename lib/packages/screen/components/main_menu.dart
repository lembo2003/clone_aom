import 'package:clone_aom/packages/screen/contact_page.dart';
import 'package:clone_aom/packages/screen/documents_page.dart';
import 'package:clone_aom/packages/screen/index_page.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        child: Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.white, // Background color for the drawer
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Container(
                    color: Colors.grey,
                    padding: EdgeInsets.only(top: 40),
                    height: 100,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Intechno Mobile App',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2, // Number of columns in the grid
                      padding: EdgeInsets.all(25),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        // _buildMenuItem(context, Icons.inventory, 'Stock', [
                        //   _buildDialogOption(
                        //     context,
                        //     Icons.category,
                        //     'Product',
                        //     () => {},
                        //   ),
                        //   _buildDialogOption(
                        //     context,
                        //     Icons.edit,
                        //     'Stock Correction',
                        //     () {},
                        //   ),
                        //   _buildDialogOption(
                        //     context,
                        //     Icons.compare_arrows,
                        //     'Internal Move',
                        //     () {},
                        //   ),
                        //   _buildDialogOption(
                        //     context,
                        //     Icons.local_shipping,
                        //     'Customer Delivery',
                        //     () {},
                        //   ),
                        //   _buildDialogOption(
                        //     context,
                        //     Icons.input,
                        //     'Supplier Arrival',
                        //     () {},
                        //   ),
                        //   _buildDialogOption(
                        //     context,
                        //     Icons.inventory,
                        //     'Inventory',
                        //     () {},
                        //   ),
                        // ]),
                        // _buildMenuItem(
                        //   context,
                        //   Icons.factory,
                        //   'Manufacturing',
                        //   [
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.assignment,
                        //       'Manufacturing Order',
                        //       () {},
                        //     ),
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.build,
                        //       'Operation Order',
                        //       () {},
                        //     ),
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.schedule,
                        //       'Planned Operations',
                        //       () {},
                        //     ),
                        //   ],
                        // ),
                        _buildMenuItem(context, Icons.people, 'HCM', [
                          // _buildDialogOption(
                          //   context,
                          //   Icons.lightbulb,
                          //   'Leads',
                          //   () {},
                          // ),
                          // _buildDialogOption(
                          //   context,
                          //   Icons.person,
                          //   'Prospects',
                          //   () {},
                          // ),
                          // _buildDialogOption(
                          //   context,
                          //   Icons.trending_up,
                          //   'Opportunities',
                          //   () {},
                          // ),
                          // _buildDialogOption(
                          //   context,
                          //   Icons.group,
                          //   'Clients',
                          //   () {},
                          // ),
                          _buildDialogOption(
                            context,
                            Icons.contacts,
                            'HCM',
                            () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactPage(),
                                ),
                              );
                            },
                          ),
                          //   _buildDialogOption(
                          //     context,
                          //     Icons.tour,
                          //     'Tours',
                          //     () {},
                          //   ),
                          //   _buildDialogOption(
                          //     context,
                          //     Icons.event,
                          //     'Events',
                          //     () {},
                          //   ),
                        ]),
                        // _buildMenuItem(
                        //   context,
                        //   Icons.support_agent,
                        //   'Help Desk',
                        //   [
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.confirmation_number,
                        //       'My Tickets',
                        //       () {},
                        //     ),
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.group,
                        //       'My Team Tickets',
                        //       () {},
                        //     ),
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.add,
                        //       'Create Ticket',
                        //       () {},
                        //     ),
                        //   ],
                        // ),
                        // _buildMenuItem(context, Icons.work, 'HR', [
                        //   _buildExpandableDialogOption(context, 'Timesheets', [
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.timer,
                        //       'Active Timer',
                        //       () {},
                        //     ),
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.schedule,
                        //       'Timesheets',
                        //       () {},
                        //     ),
                        //   ]),
                        //   _buildExpandableDialogOption(context, 'Expenses', [
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.money,
                        //       'Expense Lines',
                        //       () {},
                        //     ),
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.receipt,
                        //       'Expenses',
                        //       () {},
                        //     ),
                        //   ]),
                        //   _buildExpandableDialogOption(
                        //     context,
                        //     'Leave Requests',
                        //     [
                        //       _buildDialogOption(
                        //         context,
                        //         Icons.beach_access,
                        //         'Leaves',
                        //         () {},
                        //       ),
                        //       _buildDialogOption(
                        //         context,
                        //         Icons.check_circle,
                        //         'Complete Request',
                        //         () {},
                        //       ),
                        //     ],
                        //   ),
                        // ]),
                        // _buildMenuItem(context, Icons.verified, 'Quality', [
                        //   _buildDialogOption(
                        //     context,
                        //     Icons.check,
                        //     'Control Entries',
                        //     () {},
                        //   ),
                        // ]),
                        // _buildMenuItem(context, Icons.build, 'Intervention', [
                        //   _buildExpandableDialogOption(
                        //     context,
                        //     'Interventions',
                        //     [
                        //       _buildDialogOption(
                        //         context,
                        //         Icons.timer,
                        //         'Active Intervention',
                        //         () {},
                        //       ),
                        //       _buildDialogOption(
                        //         context,
                        //         Icons.today,
                        //         'Of the Day',
                        //         () {},
                        //       ),
                        //       _buildDialogOption(
                        //         context,
                        //         Icons.schedule,
                        //         'Planned',
                        //         () {},
                        //       ),
                        //       _buildDialogOption(
                        //         context,
                        //         Icons.history,
                        //         'History',
                        //         () {},
                        //       ),
                        //     ],
                        //   ),
                        //   _buildExpandableDialogOption(context, 'Equipments', [
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.devices,
                        //       'Customer Park',
                        //       () {},
                        //     ),
                        //   ]),
                        // ]),
                        // _buildMenuItem(context, Icons.shopping_cart, 'Sales', [
                        //   _buildExpandableDialogOption(
                        //     context,
                        //     'Sales Follow-Up',
                        //     [
                        //       _buildDialogOption(
                        //         context,
                        //         Icons.category,
                        //         'Products & Services',
                        //         () {},
                        //       ),
                        //       _buildDialogOption(
                        //         context,
                        //         Icons.description,
                        //         'Sale Quotations',
                        //         () {},
                        //       ),
                        //       _buildDialogOption(
                        //         context,
                        //         Icons.shopping_bag,
                        //         'Sale Orders',
                        //         () {},
                        //       ),
                        //       _buildDialogOption(
                        //         context,
                        //         Icons.group,
                        //         'Clients',
                        //         () {},
                        //       ),
                        //     ],
                        //   ),
                        // ]),
                        // _buildMenuItem(context, Icons.task, 'Project', [
                        //   _buildDialogOption(
                        //     context,
                        //     Icons.timer,
                        //     'Active Project',
                        //     () {},
                        //   ),
                        //   _buildDialogOption(
                        //     context,
                        //     Icons.folder,
                        //     'Projects',
                        //     () {},
                        //   ),
                        //   _buildDialogOption(
                        //     context,
                        //     Icons.business,
                        //     'Business Projects',
                        //     () {},
                        //   ),
                        //   _buildDialogOption(
                        //     context,
                        //     Icons.check_circle,
                        //     'Tasks',
                        //     () {},
                        //   ),
                        // ]),
                        _buildMenuItem(context, Icons.folder, 'DMS', [
                          _buildDialogOption(
                            context,
                            Icons.folder_open,
                            'All Documents',
                            () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DocumentsPage(),
                                ),
                              );
                            },
                          ),
                        ]),
                        // _buildMenuItem(
                        //   context,
                        //   Icons.shopping_bag,
                        //   'Purchase',
                        //   [
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.request_page,
                        //       'Internal Requests',
                        //       () {},
                        //     ),
                        //     _buildDialogOption(
                        //       context,
                        //       Icons.add,
                        //       'Create Request',
                        //       () {},
                        //     ),
                        //   ],
                        // ),
                        _buildMenuItem(context, Icons.home, 'HOME', []),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    List<Widget> options,
  ) {
    return GestureDetector(
      onTap: () {
        if (options.isNotEmpty) {
          _showOptionsDialog(context, label, options);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => IndexPage()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color for menu items
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.black), // Black icon
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.black, // Black label
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(
    BuildContext context,
    String title,
    List<Widget> options,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  ),
                ),
                SizedBox(height: 20),
                ...options,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogOption(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.black),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableDialogOption(
    BuildContext context,
    String label,
    List<Widget> subOptions,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        ...subOptions,
      ],
    );
  }
}

/*
* Example how to implement function for options
*
* Widget _buildDialogOption(BuildContext context, IconData icon, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap, // Execute the passed action
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue[900]!, width: 2),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.black),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
*
* assign action
* _buildDialogOption(
  context,
  Icons.category,
  'Product',
  () {
    // Navigate to Product screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen()));
  },
),
_buildDialogOption(
  context,
  Icons.edit,
  'Stock Correction',
  () {
    // Perform stock correction logic
    print('Stock Correction clicked');
  },
),
* */
