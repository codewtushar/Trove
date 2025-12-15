import 'package:Trove/pages/addAssetsPage.dart';
import 'package:Trove/pages/homePage.dart';
import 'package:Trove/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int currentIndex = 0;

  final screens = [
    Homepage(),
    Addassetspage(),
    Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Colors.grey[900],
        currentIndex: currentIndex,
        iconSize: 25,
        selectedItemColor: Color(0xfffffff2),
        unselectedItemColor: Colors.grey[500],
        selectedFontSize: 15,
        unselectedLabelStyle: GoogleFonts.montserratAlternates(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        selectedLabelStyle: GoogleFonts.montserratAlternates(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
