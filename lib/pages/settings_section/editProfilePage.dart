import 'package:Trove/components/textfields.dart';
import 'package:Trove/provider_services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Editprofilepage extends ConsumerStatefulWidget {
  const Editprofilepage({super.key});

  @override
  ConsumerState<Editprofilepage> createState() => _EditprofilepageState();
}

class _EditprofilepageState extends ConsumerState<Editprofilepage> {

  void editProfile({required Map<String, dynamic> oldData}) async {
    final user = ref.read(authProvider).value;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'First name': firstnameController.text.isEmpty ? oldData['First name'] : firstnameController.text,
      'Last name': lastnameController.text.isEmpty ? oldData['Last name'] : lastnameController.text,
      'Age': ageController.text.isEmpty ? oldData["Age"] : ageController.text,
      'Email': emailController.text.isEmpty ? oldData['Email'] : emailController.text,
      'Password': passController.text.isEmpty ? oldData['Password'] : passController.text,
    });
  }

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userdata = ref.watch(userDataProvider);
    return Scaffold(
      backgroundColor: Color(0xffFBFBEF),
      appBar: AppBar(
        backgroundColor: Color(0xfffffff2),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.martianMono(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image(image: AssetImage('lib/assets/images/top.png')),
                  Positioned(
                    right: 163,
                    top: 70,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[400],
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[900],
                        size: 70,
                      ),
                    ),
                  ),
                ],
              ),
              userdata.when(
                data: (data) => Column(
                  children: [
                    Text(
                      "${data['First name']} ${data['Last name']}",
                      style: GoogleFonts.martianMono(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          inputContainer(
                            textEditingController: firstnameController,
                            hinttext: "${data['First name']}",
                          ),
                          SizedBox(height: 20),
                          inputContainer(
                            textEditingController: lastnameController,
                            hinttext: "${data['Last name']}",
                          ),
                          SizedBox(height: 20),
                          inputContainer(
                            textEditingController: ageController,
                            hinttext: "${data['Age']}",
                          ),
                          SizedBox(height: 20),
                          inputContainer(
                            textEditingController: emailController,
                            hinttext: "${data['Email']}",
                          ),
                          SizedBox(height: 20),
                          inputContainer(
                            ispassword: true,
                            textEditingController: passController,
                            hinttext: "${data['Password']}",
                          ),
                          SizedBox(height: 80),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0XFF0B7EFB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  editProfile(oldData: data);
                                  ref.invalidate(userDataProvider);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        "Profile Updated!",
                                        style: GoogleFonts.martianMono(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Save",
                                  style: GoogleFonts.montserratAlternates(
                                    color: Color(0xffFBFBEF),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                error: (error, _) => Text(error.toString()),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
