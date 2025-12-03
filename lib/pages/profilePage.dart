import 'package:Trove/pages/settings_section/faq_page.dart';
import 'package:Trove/pages/settings_section/help_support_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Trove/pages/logInPage.dart';
import 'package:Trove/provider_services/firebase_service.dart';

class Profilepage extends ConsumerWidget {
  const Profilepage({super.key});

  Future<void> showLogoutDialog(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            backgroundColor: Colors.black87,
            title: Text("Logout?",style: GoogleFonts.montserratAlternates(
              fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20
            ),),
            content: Text("Are you sure you want to log out?",style: GoogleFonts.montserratAlternates(
                fontWeight: FontWeight.bold,color: Colors.white54,
            ),),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("Cancle",style: GoogleFonts.martianMono(),),
              ),
              TextButton(
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginPage(),));
                }, child: Text("Logout",style: GoogleFonts.martianMono(color: Colors.red),),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userdata = ref.watch(userDataProvider);
    final totalItems = ref.watch(totalItemProvider);
    return Scaffold(
      backgroundColor: Color(0xfffffff2),
      appBar: AppBar(
        backgroundColor: Color(0xfffffff2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.martianMono(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[700]),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(14)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 35,
                      child: Icon(Icons.person,size: 45,color: Colors.grey[900],),
                    ),
                    SizedBox(height: 20,),
                    userdata.when(
                        data: (data){
                          print("🔥 User data from Firestore: $data");
                          final firstname = data["First name"];
                          final lastName = data["Last name"];
                          final age = data["Age"];
                          final email = data["Email"];
                          return Column(
                            children: [
                              Text("$firstname $lastName | $age",style: GoogleFonts.montserratAlternates(
                                  color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600
                              ),),
                              Text("$email",style: GoogleFonts.montserratAlternates(
                                  color: Colors.white70,fontSize: 16,fontWeight: FontWeight.w600
                              ),),
                            ],
                          );
                        },
                        error: (error, _) => Text("Something went wrong"),
                        loading: () => CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 200,
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.inventory,size: 30,color: Colors.black,),
                        totalItems.when(
                            data: (data) => Text(data.toString(),style: GoogleFonts.montserratAlternates(fontSize: 20),),
                            error: (error, _) => Text("Error $error"),
                            loading: () => CircularProgressIndicator()),
                        Text("Total Items",style: GoogleFonts.montserratAlternates(
                          fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45
                        ),)
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.category,size: 30,color: Colors.black,),
                        Text("5",style: GoogleFonts.montserratAlternates(fontSize: 20),),
                        Text("Categories",style: GoogleFonts.montserratAlternates(
                            fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black45
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Settings -",style: GoogleFonts.montserratAlternates(
                        fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white
                      ),),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                        child: Row(
                          children: [
                            Icon(Icons.edit,color: Colors.white70,),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text("Edit Profile",style: GoogleFonts.montserratAlternates(
                                fontSize: 18,color: Colors.white70
                              ),),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,color: Colors.white70,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                        child: Row(
                          children: [
                            Icon(Icons.notifications,color: Colors.white70,),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text("Notifications",style: GoogleFonts.montserratAlternates(
                                  fontSize: 18,color: Colors.white70
                              ),),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,color: Colors.white70,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FaqPage(),));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.question_answer,color: Colors.white70,),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Text("FAQ",style: GoogleFonts.montserratAlternates(
                                    fontSize: 18,color: Colors.white70
                                ),),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded,color: Colors.white70,)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                        child: GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HelpSupportPage(),)),
                          child: Row(
                            children: [
                              Icon(Icons.help_center,color: Colors.white70,),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Text("Help & Support",style: GoogleFonts.montserratAlternates(
                                    fontSize: 18,color: Colors.white70
                                ),),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded,color: Colors.white70,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.all(6),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                    onPressed: (){
                      showLogoutDialog(context);
                    }, child: Text("Logout",style: GoogleFonts.montserratAlternates(
                  color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20
                ),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
