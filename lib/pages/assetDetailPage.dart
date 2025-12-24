import 'dart:convert';
import 'package:Trove/pages/editAsseetPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../components/custom_dialog.dart';

class Assetdetailpage extends StatelessWidget {
  final String base64image;
  final String name;
  final String category;
  final String price;
  final String purchaseDate;
  final String expiryDays;
  final String serialNumber;
  final String note;
  final Timestamp addedon;
  final String docID;

  String formatDate(DateTime date) {
    return DateFormat("MMM dd, yyyy").format(date);
  }

  const Assetdetailpage({
    super.key,
    required this.base64image,
    required this.name,
    required this.category,
    required this.price,
    required this.purchaseDate,
    required this.expiryDays,
    required this.serialNumber,
    required this.note,
    required this.addedon, required this.docID,

  });


  @override
  Widget build(BuildContext context) {
    bool warranty = true;

    String warrantyStatus(DateTime? expiry) {
      if (expiry == null) return "No warranty info";

      final today = DateTime.now();
      final diff = expiry.difference(today).inDays;

      if (diff < 0) {
        warranty = false;
        return "Warranty expired ${diff.abs()} days ago";
      } else {
        warranty = true;
        return "$diff days left for warranty";
      }
    }

    Widget buildAssetImage(String? base64image) {
      if (base64image == null || base64image.trim().isEmpty) {
        return Container(
          color: Colors.grey[300],
          child: Icon(Icons.image_not_supported),
        );
      }
      try {
        return Image(
          image: MemoryImage(base64Decode(base64image)),
          fit: BoxFit.contain,
        );
      } catch (e) {
        return Container(
          color: Colors.grey[300],
          child: Icon(Icons.broken_image, size: 80, color: Colors.red),
        );
      }
    }

    return Scaffold(
      backgroundColor: Color(0xfffffff2),
      appBar: AppBar(
        backgroundColor: Color(0xfffffff2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Asset Details",
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: buildAssetImage(base64image),
              ),
              SizedBox(height: 25),
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                category,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green.withOpacity(0.1),
                    ),
                    child: Icon(Icons.currency_rupee, color: Colors.green),
                  ),
                  SizedBox(width: 10),
                  Text(
                    price,
                    style: GoogleFonts.montserratAlternates(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 100),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue.withOpacity(0.1),
                    ),
                    child: Icon(Icons.calendar_today, color: Colors.blue),
                  ),
                  SizedBox(width: 10),
                  Text(
                    purchaseDate,
                    style: GoogleFonts.montserratAlternates(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: warranty ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
                    ),
                    child: Icon(warranty ? Icons.done : Icons.hourglass_empty,color: warranty ? Colors.green : Colors.red,),
                  ),
                  SizedBox(width: 10),
                  Text(
                    warrantyStatus(DateTime.tryParse(expiryDays)),
                    style: GoogleFonts.montserratAlternates(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(0.1),
                    ),
                    child: Icon(Icons.numbers, color: Colors.deepPurple),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Serial: $serialNumber",
                    style: GoogleFonts.montserratAlternates(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Note",
                        style: GoogleFonts.montserratAlternates(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            note,
                            style: GoogleFonts.montserratAlternates(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 18,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Added on",
                            style: GoogleFonts.montserratAlternates(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            formatDate(addedon.toDate()),
                            style: GoogleFonts.montserratAlternates(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showCustomDialog(
                              context: context,
                              title: "Delete Asset?",
                              message: "Do you want to remove this asset?",
                              confirmText: "delete",
                              onConfirm: () async{
                                final uid = FirebaseAuth.instance.currentUser!.uid;
                                FirebaseFirestore.instance.collection('users').doc(uid).collection('assets').doc(docID).delete();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor : Colors.red[400],
                                    content: Text("$name deleted",style: GoogleFonts.montserratAlternates(fontWeight: FontWeight.bold),)));
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 32,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Editasseepage(
                            docID: docID,existingCat: category,existingname: name,
                            existingexpiry: expiryDays,existingnote: note,existingprice: price,existingserial: serialNumber,
                          ),));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Icon(Icons.edit, color: Colors.green, size: 30),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
