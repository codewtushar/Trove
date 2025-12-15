import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAssetsCard extends StatelessWidget {
  final String name;
  final String categoryName;
  final String price;
  final String? purchaseDate;
  final String? expiryDate;
  final String? imageBase64;

  const MyAssetsCard({
    super.key,
    required this.name,
    required this.price,
    this.purchaseDate,
    this.expiryDate,
    required this.categoryName,
    this.imageBase64,
  });

  Future openImage(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                base64Decode(imageBase64!),
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close,color: Colors.black,),
                color: Colors.white54,
                iconSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    bool warranty = false;

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

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: imageBase64 != null && imageBase64!.isNotEmpty
                        ? Center(
                            child: GestureDetector(
                              onTap: () {
                                openImage(context);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  base64Decode(imageBase64!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Icon(
                              categoryName == "Electronics"
                                  ? Icons.phone_iphone
                                  : categoryName == "Appliances"
                                  ? Icons.microwave
                                  : categoryName == "Furniture"
                                  ? Icons.chair
                                  : Icons.description_outlined,
                              color: Colors.blueGrey,
                              size: 50,
                            ),
                          ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.montserratAlternates(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        price,
                        style: GoogleFonts.montserratAlternates(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Purchased: ${purchaseDate}",
                        style: GoogleFonts.montserratAlternates(
                          color: Colors.white54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey, indent: 15, endIndent: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    warrantyStatus(DateTime.tryParse(expiryDate!)),
                    style: GoogleFonts.montserratAlternates(
                      color: warranty ? Colors.green : Colors.red.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                      wordSpacing: 2,
                      letterSpacing: 1,
                      fontSize: 17,
                    ),
                  ),
                  Icon(warranty ? Icons.done : null, color: Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
