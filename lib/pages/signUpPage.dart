import 'package:Trove/MainNavigationPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Trove/components/textfields.dart';
import 'package:Trove/pages/homePage.dart';
import 'logInPage.dart';

class Signuppage extends StatelessWidget {
   Signuppage({super.key});
   TextEditingController emailController = TextEditingController();
   TextEditingController passController = TextEditingController();
   TextEditingController firstNameController = TextEditingController();
   TextEditingController LastNameController = TextEditingController();
   TextEditingController ageController = TextEditingController();


   Future<void> signUp() async {
     try {
       final userCredential =
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailController.text.trim(),
         password: passController.text.trim(),
       );

       final uid = userCredential.user!.uid;

       await FirebaseFirestore.instance.collection('users').doc(uid).set({
         'First name': firstNameController.text.trim(),
         'Last name': LastNameController.text.trim(),
         'Age': ageController.text.trim(),
         'Email': emailController.text.trim(),
         'Password': passController.text.trim(),
         'CreatedAt': DateTime.now(),
       });

       print("SIGNUP SUCCESS: user stored in firebase");

     } on FirebaseAuthException catch (e) {
       print("AUTH ERROR: ${e.code}");

       if (e.code == 'email-already-in-use') {
         throw "This email is already registered.";
       }
       if (e.code == 'invalid-email') {
         throw "Email format is incorrect.";
       }
       if (e.code == 'weak-password') {
         throw "Password must be at least 6 characters.";
       }

       throw e.message!;
     } catch (e) {
       print("OTHER ERROR: $e");
       throw "Something went wrong: $e";
     }
   }



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffff2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: Colors.black.withOpacity(0.3)
                  )
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: AssetImage('lib/assets/images/logo.png'),
                  width: 75,
                ),
              ),
            ),
            SizedBox(height: 15,),
            Text("HELLO AGAIN",style: GoogleFonts.belleza(
                fontSize: 40,fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10,),
            Text("Welcome back, You've been missed",style: GoogleFonts.martianMono(wordSpacing: 1,color: Colors.black54,fontSize: 17),),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: inputContainer(textEditingController: firstNameController, hinttext: "First Name"),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: inputContainer(textEditingController: LastNameController, hinttext: "Last Name"),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: inputContainer(textEditingController: ageController, hinttext: "Age"),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: inputContainer(textEditingController: emailController, hinttext: "Email"),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: inputContainer(textEditingController: passController, hinttext: "Password",ispassword: true,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 30),
              child: GestureDetector(
                onTap: () async {
                  try {
                    await signUp();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainNavigationPage()),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12)
                  ),
                  child: Center(child: Text("Sign Up",style: GoogleFonts.belleza(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a member? ",style: GoogleFonts.martianMono(color: Colors.black54),),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage(),));
                    },
                    child: Text("Login",style: GoogleFonts.martianMono(color: Colors.lightBlue),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
