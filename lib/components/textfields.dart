import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class inputContainer extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hinttext;
  final bool ispassword;

  const inputContainer({super.key, required this.textEditingController, required this.hinttext, this.ispassword = false});

  @override
  State<inputContainer> createState() => _inputContainerState();
}

class _inputContainerState extends State<inputContainer> {
  bool obsecureText = true;
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
        obscureText: widget.ispassword ? obsecureText : false,
        controller: widget.textEditingController,
        style: GoogleFonts.martianMono(
            color: Colors.grey[700]
        ),
        decoration: InputDecoration(
            suffixIcon: widget.ispassword ? IconButton(
                onPressed: (){
                  setState(() {
                    obsecureText = !obsecureText;
                  });
                },
                icon: Icon(
                  obsecureText ? Icons.visibility_off : Icons.visibility
                ),) : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintText: widget.hinttext,
            hintStyle: GoogleFonts.martianMono(color: Colors.black38),
        ),
      ),
    );
  }
}
