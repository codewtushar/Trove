import 'package:Trove/MainNavigationPage.dart';
import 'package:Trove/components/custom_dialog.dart';
import 'package:Trove/pages/assetDetailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Trove/components/myAssetsCard.dart';
import 'package:Trove/components/noAssetsPage.dart';
import 'package:Trove/pages/addAssetsPage.dart';
import 'package:Trove/pages/homePage.dart';
import 'package:Trove/provider_services/firebase_service.dart';

class MyAssetsPage extends ConsumerWidget {
  const MyAssetsPage({super.key, required this.categoryName});
  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetsAsync = ref.watch(categoryAssetsProvider(categoryName));
    final totalItems = ref.watch(categoryCountProvider(categoryName));

    return Scaffold(
      backgroundColor: Color(0xfffffff2),
      appBar: AppBar(
        backgroundColor: Color(0xfffffff2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Assets",
          style: GoogleFonts.montserratAlternates(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainNavigationPage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[700]),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Category : ",
                            style: GoogleFonts.montserratAlternates(
                              color: Colors.white54,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            categoryName,
                            style: GoogleFonts.montserratAlternates(
                              color: Colors.grey[300],
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "Total Items : ",
                            style: GoogleFonts.montserratAlternates(
                              color: Colors.white54,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          totalItems.when(
                            data: (data) => Text(
                              data.toString(),
                              style: GoogleFonts.montserratAlternates(
                                color: Colors.grey[300],
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            error: (error, _) => Text("error, $error"),
                            loading: () => CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Your Items",
                style: GoogleFonts.montserratAlternates(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontSize: 22,
                ),
              ),
          assetsAsync.when(
            data: (data) {
              if (data.docs.isEmpty) {
                return Noassetspage();
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: data.docs.length,      // FIXED
                  itemBuilder: (context, index) {
                    final doc = data.docs[index];   // FIXED
                    final map = doc.data() as Map<String, dynamic>;
                    final name = map['name'] ?? "No Name";
                    final price = map['price'] ?? "0";
                    final expiry = map['expiryDate'] ?? "";
                    final purchase = map['purchaseDate'] ?? "-";
                    final serialNumber = map['serialNumber'];
                    final addedon = map['createdAt'];
                    final note = map['note'];
                    final docId = doc.id;


                    return Dismissible(
                      key: Key(doc.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        showCustomDialog(
                          context: context,
                          title: "Delete Asset?",
                          message: "Do you want to remove this asset?",
                          confirmText: "delete",
                          onConfirm: () {
                            final uid = FirebaseAuth.instance.currentUser!.uid;
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .collection('assets')
                                .doc(doc.id)
                                .delete();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor : Colors.red[400],
                                content: Text("$name deleted",style: GoogleFonts.montserratAlternates(fontWeight: FontWeight.bold),)));
                          },
                        );

                      },
                      background: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red.withOpacity(0.9),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 300.0),
                          child: Icon(Icons.delete,color: Colors.white70,size: 30,),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Assetdetailpage(
                                base64image: (map['base64Image'] ?? "").toString(),
                                name: name.toString(),
                                category: categoryName.toString(),
                                price: price.toString(),
                                purchaseDate: purchase.toString(),
                                expiryDays: expiry?.toString() ?? "",
                                serialNumber: serialNumber?.toString() ?? "-",
                                note: note?.toString() ?? "",
                                addedon: addedon,
                                docID: docId,
                              ),
                            ),
                          );
                        },
                        child: MyAssetsCard(
                          name: name,
                          price: price,
                          expiryDate: expiry,
                          purchaseDate: purchase,
                          categoryName: categoryName,
                          imageBase64: map['base64Image'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            error: (error, _) => Center(child: Text("Error, $error")),
            loading: () => Center(child: CircularProgressIndicator()),
          )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}
