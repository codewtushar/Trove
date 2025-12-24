import 'dart:io';
import 'dart:convert';
import 'package:Trove/MainNavigationPage.dart';
import 'package:Trove/pages/BarcodeScannerPage.dart';
import 'package:Trove/pages/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Trove/components/textfields.dart';
import 'package:http/http.dart' as http;

class Addassetspage extends StatefulWidget {

  Addassetspage({super.key});

  @override
  State<Addassetspage> createState() => _AddassetspageState();
}

class _AddassetspageState extends State<Addassetspage> {

  var categories = [
    "Electronics", "Appliances", "Furniture", "Documents"
  ];
  String selectedCategory = "Select Category";

  Future<void> addAssetToD() async{
    final user = FirebaseAuth.instance.currentUser;
    if(user == null){
      throw Exception("User not logged in");
    }
    final uid = user.uid;

    String? base64Image;
    if(selectedImage != null){
      base64Image = await imageToBase64(selectedImage!);
    }

    final data = {
      'name' : AssetNameController.text.trim(),
      'category' : selectedCategory,
      'purchaseDate' : PurchaseDateController.text.trim(),
      'expiryDate' : expiryDateController.text.trim(),
      'price' : PriceController.text.trim(),
      'serialNumber' : SerialNumberController.text.trim(),
      'note' : NoteController.text.trim(),
      'createdAt' : Timestamp.now(),
      'base64Image': base64Image,
    };

    data.removeWhere((key, value) => value == null || value == "");
    
    await FirebaseFirestore.instance.collection('users').doc(uid).collection('assets').add(data);
  }


  TextEditingController AssetNameController = TextEditingController();
  TextEditingController PurchaseDateController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  TextEditingController SerialNumberController = TextEditingController();
  TextEditingController NoteController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();


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

  //Picking the images from gallery
  File? selectedImage;
  Future selectImage() async{
    final picked = await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    if(picked != null){
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  //BASE64 LOGIC
  Future<String> imageToBase64(File file) async{
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  String scanBarcodeResult = "";
  Future<void> scanAsset() async{
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => Barcodescannerpage(),));
    if(result == null) return;
    setState(() {
      scanBarcodeResult = result;
    });
    final mockData = getMockProductData(result);

    if (mockData != null) {
      setState(() {
        AssetNameController.text = mockData['name'] ?? '';
        NoteController.text = mockData['description'] ?? '';
        selectedCategory = mockData['category'] ?? selectedCategory;
        PriceController.text = mockData['price'] ?? '';
        SerialNumberController.text = mockData['serial'] ?? '';
        expiryDateController.text = mockData['expiry'] ?? '';
      });
    }
  }

  Future<Map<String, dynamic>?> fetchDataFromAPI(String barcode) async{
    final url = Uri.parse(
      'https://api.upcitemdb.com/prod/trial/lookup?upc=$barcode',
    );

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json'
      },
    );
    print("UPC RESPONSE: ${response.body}");

    if(response.statusCode != 200) return null;

    final data = json.decode(response.body);
    if (data['items'] == null || data['items'].isEmpty) return null;

    final item = data['items'][0];

    return{
      'name': item['title'] ?? "",
      'description': item['description'] ?? "",
      'category': item['category'] ?? "",
      'price': item['price'] ?? "",
      'image': item['images']?.first ?? "",
    };
  }

  Map<String, String>? getMockProductData(String barcode) {
    if (barcode == '012345678905') {
      return {
        'name': 'Apple iPhone 13',
        'category': 'Electronics',
        'description': '128GB, Midnight Black',
        'price': '60000',
        'serial': '10023456'
      };
    }
    if (barcode == '123456789') {
      return {
        'name': 'Samsung Fridge',
        'category': 'Electronics',
        'description': 'Samsung 419 L, 3 Star, Convertible 5-in-1, Digital Inverter, Frost Free Double Door',
        'price': '120000',
        'serial': '12345678',
        'expiry': '10-10-2030',
      };
    }

    return null; // no mock data
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xfffffff2),
      appBar: AppBar(
        backgroundColor: Color(0xfffffff2),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          "Add New Asset",
          style: GoogleFonts.martianMono(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async{
                    await scanAsset();
                    print(scanBarcodeResult);
                  },
                  child: Container(
                    height: 130,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.qr_code_scanner,
                          color: Colors.white,
                          size: 45,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          scanBarcodeResult.isEmpty
                              ? "Scan Barcode"
                              : "Barcode Attached",
                          style: GoogleFonts.montserratAlternates(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        if (scanBarcodeResult.isEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            "Auto-fill product details",
                            style: GoogleFonts.montserratAlternates(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),
                Text(
                  "Asset Name*",
                  style: GoogleFonts.montserratAlternates(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                inputContainer(
                  textEditingController: AssetNameController,
                  hinttext: "e.g., MacBook Pro, Iphone 17",
                ),
                SizedBox(height: 15),
                Text(
                  "Category*",
                  style: GoogleFonts.montserratAlternates(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: categories.contains(selectedCategory)
                            ? selectedCategory
                            : null,
                        hint: Text(
                          selectedCategory,
                          style: GoogleFonts.montserratAlternates(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        style: GoogleFonts.montserratAlternates(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,fontSize: 18
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        dropdownColor: Color(0xfffffff2),
                        items: categories
                            .map(
                              (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                      ),
                    )

                  ),

                ),

                SizedBox(height: 15),
                Text(
                  "Purchase Date",
                  style: GoogleFonts.montserratAlternates(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: PurchaseDateController,
                  onTap: (){
                    selectDate(context,PurchaseDateController);
                  },
                  style: GoogleFonts.martianMono(color: Colors.grey[700]),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: Icon(Icons.calendar_today_sharp, color: Colors.grey[700],),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: "Select Purchase Date",
                    hintStyle: GoogleFonts.montserratAlternates(color: Colors.black38,fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 15),
                Text(
                  "Expiry Date",
                  style: GoogleFonts.montserratAlternates(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: expiryDateController,
                  onTap: (){
                    selectDate(context,expiryDateController);
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
                SizedBox(height: 15),
                Text(
                  "Purchase Price",
                  style: GoogleFonts.montserratAlternates(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                inputContainer(textEditingController: PriceController, hinttext: "e.g, 9999"),
                SizedBox(height: 15),
                Text(
                  "Serial Number",
                  style: GoogleFonts.montserratAlternates(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                inputContainer(textEditingController: SerialNumberController, hinttext: "optional"),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    selectImage();
                  },
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(18),
                      image: selectedImage != null ? DecorationImage(image: FileImage(selectedImage!),
                          fit: BoxFit.fitHeight, alignment: Alignment.centerLeft) : null
                    ),
                    child: selectedImage == null ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 24,backgroundColor: Colors.grey[900],
                          child: Icon(Icons.upload_file,color: Colors.white70,),
                        ),
                        Text("Click here to upload your image",style: GoogleFonts.montserratAlternates(
                          fontWeight: FontWeight.w600,color: Colors.grey[700]
                        ),)
                      ],
                    ) : Container(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("Image Selected ✔",style: GoogleFonts.montserratAlternates(fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Notes",
                  style: GoogleFonts.montserratAlternates(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    style: GoogleFonts.montserratAlternates(),
                    controller: NoteController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Additional Information...",
                      hintStyle: GoogleFonts.montserratAlternates(
                        fontWeight: FontWeight.bold,color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.all(12)
                    ),
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(6),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextButton(
                      onPressed: () async{

                        if(AssetNameController.text.trim().isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                          Text("Please enter asset name",style: GoogleFonts.montserratAlternates(fontWeight: FontWeight.bold),)));
                          return;
                        }
                        if (selectedCategory == "Select Category") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select a category", style: GoogleFonts.montserratAlternates(fontWeight: FontWeight.bold),)),);
                          return;
                        }

                        try{
                          await addAssetToD();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,content:
                          Text("Asset added successfully!",style: GoogleFonts.martianMono(
                            fontWeight: FontWeight.bold,
                          ),)));
                          if(!mounted) return;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MainNavigationPage(),));
                        }catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
                        }
                      }, child: Text("Save Asset",style: GoogleFonts.montserratAlternates(
                    color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20
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
