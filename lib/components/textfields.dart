import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class inputContainer extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hinttext;

  const inputContainer({super.key, required this.textEditingController, required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12)
      ),
      child: TextField(
        controller: textEditingController,
        style: GoogleFonts.martianMono(
            color: Colors.grey[700]
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintText: hinttext,
            hintStyle: GoogleFonts.martianMono(color: Colors.black38)
        ),
      ),
    );
  }
}
