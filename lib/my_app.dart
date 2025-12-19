import 'package:flutter/material.dart';
import 'package:to_do/core/app_colors.dart';
import 'package:to_do/features/add/view/add_task_page.dart';
import 'package:to_do/features/home/view/home_page.dart';
import 'package:to_do/features/profile/view/profile_page.dart';
import 'package:to_do/features/search/view/search_page.dart';
import 'package:to_do/features/tasks/view/tasks_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  final pages = const [
    HomePage(),
    TasksPage(),
    AddTaskPage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddTaskPage();
              },
            ),
          );
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
          ),

          child: Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_outlined, "Home", 0),
              _navItem(Icons.task_alt, "Tasks", 1),
              const SizedBox(width: 40), // space for FAB
              _navItem(Icons.search, "Search", 3),
              _navItem(Icons.person, "Profile", 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;

    return InkWell(
      onTap: () => setState(() => currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.purple : Colors.grey, size: 30),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.purple : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
