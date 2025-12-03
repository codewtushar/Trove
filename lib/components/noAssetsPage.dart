import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/addAssetsPage.dart';

class Noassetspage extends StatelessWidget {
  const Noassetspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              "No items yet",
              style: GoogleFonts.montserratAlternates(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Add your first item to get started",
              style: GoogleFonts.montserratAlternates(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class addAssetButton extends StatelessWidget {
  const addAssetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.grey[900],
      elevation: 0,
      child: Icon(Icons.add, color: Colors.white, size: 30),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Addassetspage()),
        );
      },
    );
  }
}

