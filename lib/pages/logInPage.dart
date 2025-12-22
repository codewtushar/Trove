import 'package:Trove/MainNavigationPage.dart';
import 'package:Trove/components/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Trove/pages/homePage.dart';
import 'package:Trove/pages/signUpPage.dart';
import 'package:Trove/provider_services/firebase_service.dart';

class loginPage extends ConsumerWidget {
  const loginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xfffffff2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image(
                image: AssetImage('lib/assets/images/logo.png'),
                width: 150,
              ),
            ),
            SizedBox(height: 50),
            Text(
              "HELLO AGAIN",
              style: GoogleFonts.belleza(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Welcome back, You've been missed",
              style: GoogleFonts.martianMono(
                wordSpacing: 1,
                color: Colors.black54,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: inputContainer(
                  textEditingController: emailController, hinttext: "Email")
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                child: inputContainer(
                    textEditingController: passController, hinttext: "Password",ispassword: true,)
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 30,
              ),
              child: GestureDetector(
                onTap: () async {
                  if (emailController.text.isEmpty ||
                      passController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all textfields")),
                    );
                    return;
                  }

                  if (!emailController.text.trim().contains("@")) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a valid email")),
                    );
                    return;
                  }

                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passController.text.trim(),
                    );

                    ref.invalidate(userDataProvider);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainNavigationPage(),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    String message = "";

                    if (e.code == "user-not-found") {
                      message =
                          "No account found with this email. Try signing up.";
                    } else if (e.code == "wrong-password") {
                      message = "Incorrect password. Please try again.";
                    } else if (e.code == "invalid-email") {
                      message = "Invalid email format.";
                    } else {
                      message = "Login failed: ${e.message}";
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          message,
                          style: GoogleFonts.montserratAlternates(),
                        ),
                      ),
                    );
                  }
                },

                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.belleza(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style: GoogleFonts.martianMono(color: Colors.black54),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signuppage()),
                    );
                  },
                  child: Text(
                    "Register now",
                    style: GoogleFonts.martianMono(color: Colors.lightBlue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
