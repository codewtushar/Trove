import 'package:Trove/MainNavigationPage.dart';
import 'package:Trove/pages/homePage.dart';
import 'package:Trove/pages/settings_section/faq_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffff2),
      appBar: AppBar(
        backgroundColor: Color(0xfffffff2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Help & Support",
          style: GoogleFonts.martianMono(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[700]),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.support_agent,size: 50,color: Color(0xfffffff2),),
                        SizedBox(height: 6,),
                        Text("How can we help you?",style: GoogleFonts.montserratAlternates(
                            fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xfffffff2)
                        ),),
                        SizedBox(height: 6,),
                        Text("We're here to help you with any questions",style: GoogleFonts.montserratAlternates(
                            fontWeight: FontWeight.w600,fontSize: 16,color: Colors.grey
                        ),),
                        Text("or issues you might have with Trove.",style: GoogleFonts.montserratAlternates(
                            fontWeight: FontWeight.w600,fontSize: 16,color: Colors.grey
                        ),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FaqPage(),));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Frequently asked questions",style: GoogleFonts.montserratAlternates(
                            fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16
                          ),),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Text("Contact Information",style: GoogleFonts.montserratAlternates(
                  fontSize: 17,fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.email,size: 40,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email",style: GoogleFonts.montserratAlternates(fontWeight: FontWeight.bold,fontSize: 17),),
                                Text("support@trove.com",style: GoogleFonts.montserratAlternates(fontWeight: FontWeight.w600,color: Colors.black54),)
                              ],
                            ),
                          ],
                        ),
                        Divider(color: Colors.black,height: 25,),
                        Row(
                          children: [
                            Icon(Icons.phone,size: 40,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone",style: GoogleFonts.montserratAlternates(fontWeight: FontWeight.bold,fontSize: 17),),
                                Text("+91 1234567890",style: GoogleFonts.montserratAlternates(fontWeight: FontWeight.w600,color: Colors.black54),)
                              ],
                            ),
                          ],
                        ),
                        Divider(color: Colors.black,height: 25,),
                        Row(
                          children: [
                            Icon(Icons.watch_later,size: 40,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Response Time",style: GoogleFonts.montserratAlternates(fontWeight: FontWeight.bold,fontSize: 17),),
                                Text("within 24 hours",style: GoogleFonts.montserratAlternates(fontWeight: FontWeight.w600,color: Colors.black54),)
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Text("Common Issues",style: GoogleFonts.montserratAlternates(
                    fontSize: 17,fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.help_center,size: 35,),
                            SizedBox(width: 10,),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Login Problem?",style: GoogleFonts.montserratAlternates(
                                      fontWeight: FontWeight.bold,fontSize: 18),),
                                  Text("Check internet connection and verify \nemail/password",style: GoogleFonts.montserratAlternates(
                                      fontWeight: FontWeight.w600,color: Colors.black54),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.black,height: 25,),
                        Row(
                          children: [
                            Icon(Icons.help_center,size: 35,),
                            SizedBox(width: 10,),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Barcode not scanning?",style: GoogleFonts.montserratAlternates(
                                      fontWeight: FontWeight.bold,fontSize: 18),),
                                  Text("Ensure the barcode is valid or fill the details manually.",style: GoogleFonts.montserratAlternates(
                                      fontWeight: FontWeight.w600,color: Colors.black54),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.black,height: 25,),
                        Row(
                          children: [
                            Icon(Icons.help_center,size: 35,),
                            SizedBox(width: 10,),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Data not syncing?",style: GoogleFonts.montserratAlternates(
                                      fontWeight: FontWeight.bold,fontSize: 18),),
                                  Text("Check internet connection and app permissions",style: GoogleFonts.montserratAlternates(
                                      fontWeight: FontWeight.w600,color: Colors.black54),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainNavigationPage(),)),
                    child: Text("Go to home",
                      style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 18
                    ),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
