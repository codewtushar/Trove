import 'package:Trove/pages/settings_section/help_support_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqPage extends StatelessWidget {
   FaqPage({super.key});

  final List<faqItem> faqItems = [
    faqItem(
        question: "What is Trove?",
        answer:  "Trove is your personal digital vault that helps you track, manage, and protect your valuable possessions. Store receipts, warranties, serial numbers, and important documents all in one secure place."
    ),
    faqItem(
      question: "How do I add an asset?",
      answer: "Tap the '+' button on the home screen. You can manually enter details or use barcode scanning to automatically fill product information from our database.",
    ),
    faqItem(
      question: "What types of assets can I track?",
      answer: "You can track electronics, appliances, furniture, documents, jewelry, vehicles, and any other valuable items you own.",
    ),
    faqItem(
      question: "Can I upload images?",
      answer: "Yes! Upload photos of receipts, the product itself, warranty cards, or any related documents. Keep everything organized in one place.",
    ),
    faqItem(
      question: "Can I scan barcodes?",
      answer: "Absolutely! Use our built-in barcode scanner to quickly add products. The app will automatically fetch product details like name, category, and specifications.",
    ),
    faqItem(
      question: "Can I access Trove on multiple devices?",
      answer: "Yes! Sign in with the same account on multiple devices to access your asset vault from anywhere. All changes sync automatically.",
    ),
    faqItem(
        question: "Can I access my assets offline?",
        answer: "Currently, Trove requires an internet connection to sync your data. However, we are working on offline support."
    ),
    faqItem(
        question: "How do I delete an asset?",
        answer: "Swipe left on the asset you want to delete in the list."
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffff2),
      appBar: AppBar(
        backgroundColor: Color(0xfffffff2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "FAQ",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
        child: Center(
          child: Column(
            children: [
              Text("Got any questions?",style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,fontSize: 24
              ),),
              Text("We've got answers.",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,fontSize: 24,color: Colors.grey
              ),),
              SizedBox(height: 30,),
              Expanded(child: ListView.builder(
                itemCount: faqItems.length,
                itemBuilder: (context, index) {
                  return faqCard(item: faqItems[index]);
              },),),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xfffffff2)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Still need help? ",style: GoogleFonts.poppins(
                      fontSize: 18,fontWeight: FontWeight.w600,color: Colors.grey[600]
                    ),),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HelpSupportPage(),)),
                      child: Text("Contact Support",style: GoogleFonts.poppins(
                        fontSize: 18,fontWeight: FontWeight.w600,color: Colors.grey[800]
                      ),),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class faqCard extends StatefulWidget {
  final faqItem item;
  const faqCard({super.key, required this.item});

  @override
  State<faqCard> createState() => _faqCardState();
}

class _faqCardState extends State<faqCard> {

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(14)
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: ListTile(
              title: Text(widget.item.question,style: GoogleFonts.poppins(
                fontSize: 18,
              ),),
              trailing: isExpanded ? Icon(Icons.expand_less_rounded) : Icon(Icons.expand_more),
            ),
          ),
          if(isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Divider(color: Colors.black54,height: 1,),
                  SizedBox(height: 10,),
                  Text(widget.item.answer,style: GoogleFonts.poppins(
                    color: Colors.grey[700],fontSize: 16
                  ),),
                ],
              ),
            ),
        ],
      ),
    );
  }
}


class faqItem{
    final String question;
    final String answer;

  faqItem({required this.question, required this.answer});
}
