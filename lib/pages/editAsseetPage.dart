import 'package:Trove/components/textfields.dart';
import 'package:Trove/provider_services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Editasseepage extends ConsumerStatefulWidget {
  final String docID;
  final String existingCat;
  final String existingname;
  final String existingprice;
  final String existingserial;
  final String existingnote;
  final String existingexpiry;
  const Editasseepage({super.key, required this.docID, required this.existingCat, required this.existingname, required this.existingprice, required this.existingserial, required this.existingnote, required this.existingexpiry});

  @override
  ConsumerState<Editasseepage> createState() => _EditasseepageState();
}

class _EditasseepageState extends ConsumerState<Editasseepage> {
  TextEditingController name = TextEditingController();
  late String selected = widget.existingCat;
  var categories = ["Electronics", "Appliances", "Furniture", "Documents"];
  TextEditingController price = TextEditingController();
  TextEditingController serial = TextEditingController();
  TextEditingController expiry = TextEditingController();
  TextEditingController note = TextEditingController();

  Future<void> selectDate(BuildContext context, TextEditingController controller)async{
    DateTime? Picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child){
          return Theme(
              data: ThemeData.dark(),
              child: child!
          );
        }
    );

    if(Picked != null){
      setState(() {
        controller.text = Picked.toString().split(" ")[0];
      });
    }
  }

  void editAsset() async{
    final user = ref.read(authProvider).value;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('assets').doc(widget.docID).update({
      'name': name.text.isEmpty ? widget.existingname : name.text,
      'price': price.text.isEmpty ? widget.existingprice : price.text,
      'serialNumber': serial.text.isEmpty ? widget.existingserial : serial.text,
      'note': note.text.isEmpty ? widget.existingnote : note,
      'expiryDate': expiry.text.isEmpty ? widget.existingexpiry : expiry,
      'category': selected.isEmpty ? widget.existingCat : selected,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffff2),
      appBar: AppBar(
        backgroundColor: Color(0xfffffff2),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Edit Asset",
          style: GoogleFonts.martianMono(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    widget.existingname,
                    style: GoogleFonts.montserratAlternates(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    widget.existingCat,
                    style: GoogleFonts.montserratAlternates(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black45,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                inputContainer(
                  textEditingController: name,
                  hinttext: "Enter updated Name",
                ),
                SizedBox(height: 10),
                inputContainer(
                  textEditingController: price,
                  hinttext: "price",
                ),
                SizedBox(height: 15),
                inputContainer(
                  textEditingController: serial,
                  hinttext: "serial",
                ),
                SizedBox(height: 20,),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    style: GoogleFonts.montserratAlternates(),
                    controller: note,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Additional Information...",
                        hintStyle: GoogleFonts.martianMono(
                          fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 15
                        ),
                        contentPadding: EdgeInsets.all(12)
                    ),
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: expiry,
                  onTap: (){
                    selectDate(context,expiry);
                  },
                  style: GoogleFonts.martianMono(color: Colors.grey[700]),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: Icon(Icons.calendar_today_sharp, color: Colors.grey[700],),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: "Select Expiry Date",
                    hintStyle: GoogleFonts.montserratAlternates(color: Colors.black38,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton<String>(
                    elevation: 0,
                    isExpanded: true,
                    dropdownColor: Colors.grey[200],
                    style: GoogleFonts.martianMono(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.w600),
                    underline: SizedBox(),
                    value: selected,
                    hint: Text("Select category"),
                    items: categories
                        .map((e) => DropdownMenuItem(child: Text(e), value: e))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selected = value!;
                      });
                    },
                  ),
                ),
                Spacer(),
                Center(
                  child: TextButton(
                      onPressed: () {
                        editAsset();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              "Asset Updated!",
                              style: GoogleFonts.martianMono(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      }, child: Text("Save changes",style: GoogleFonts.martianMono(
                    fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 18
                  ),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
