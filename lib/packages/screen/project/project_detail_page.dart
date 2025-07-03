import 'package:clone_aom/l10n/app_localizations.dart';
import 'package:clone_aom/packages/screen/project/project_overview_page.dart';
import 'package:clone_aom/packages/screen/project/project_resources_page.dart';
import 'package:clone_aom/packages/screen/project/project_wbs_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ProjectDetail extends StatefulWidget {
  final int? projectId;
  const ProjectDetail({super.key, required this.projectId});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  int _selectedIndex = 0;

  void _navigateNavBarProject(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _pages => [
    ProjectOverviewPage(projectId: widget.projectId),
    ProjectWbsPage(projectId: widget.projectId),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Gantt', style: TextStyle(fontFamily: 'Montserrat')),
          Text('Currently skipped', style: TextStyle(fontFamily: 'Montserrat')),
        ],
      ),
    ),
    ProjectResourcesPage(projectId: widget.projectId),
  ];

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
          AppLocalizations.of(context)!.projectDetail_title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.person_2, color: Colors.black),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   icon: const Icon(Icons.notifications, color: Colors.black),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              //TODO refetch data
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: GNav(
              onTabChange: _navigateNavBarProject,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              backgroundColor: Colors.white,
              color: Colors.grey[600],
              activeColor: Colors.black,
              tabBackgroundColor: Colors.deepPurple.shade50,
              gap: 8,
              iconSize: 24,
              textStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              tabs: [
                GButton(
                  icon: Icons.dashboard_outlined,
                  text: AppLocalizations.of(context)!.projectDetail_overview,
                ),
                GButton(
                  icon: Icons.account_tree_outlined,
                  text: AppLocalizations.of(context)!.projectDetail_wbs,
                ),
                GButton(icon: Icons.timeline, text: 'Gantt'),
                GButton(
                  icon: Icons.people_outline,
                  text: AppLocalizations.of(context)!.projectDetail_resources,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
