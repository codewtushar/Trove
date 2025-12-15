import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Trove/pages/addAssetsPage.dart';
import 'package:Trove/pages/my_assets_page.dart';
import 'package:Trove/pages/profilePage.dart';
import 'package:Trove/provider_services/firebase_service.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  int currentIndex = 0;
  final Screens = [
    Homepage(),
    Addassetspage(),
    Profilepage(),
  ];


  @override
  Widget build(BuildContext context) {
    final userdata = ref.watch(userDataProvider);
    final totalItem = ref.watch(totalItemProvider);
    final warrantyCount = ref.watch(warrentyProvider);
    final electronicsCount = ref.watch(categoryCountProvider("Electronics"));
    final appliancesCount = ref.watch(categoryCountProvider("Appliances"));
    final furnitureCount = ref.watch(categoryCountProvider("Furniture"));
    final documentCount = ref.watch(categoryCountProvider("Documents"));

    return Scaffold(
      backgroundColor: Color(0xfffffff2),
      appBar: AppBar(
        backgroundColor: Color(0xfffffff2),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Trove",
          style: GoogleFonts.martianMono(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userdata.when(
                data: (data) {
                  final name = data["First name"];
                  return Text(
                    "Welcome back, $name",
                    style: GoogleFonts.montserratAlternates(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.grey[800],
                    ),
                  );
                },
                error: (err, _) => Text("Error loading user"),
                loading: () => CircularProgressIndicator(),
              ),
              SizedBox(height: 5),
              Text(
                "Manage all your assets at one place",
                style: GoogleFonts.montserratAlternates(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: totalItem.when(
                          data: (data) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Total Items",
                                style: GoogleFonts.martianMono(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                data.toString(),
                                style: GoogleFonts.martianMono(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          error: (error,_) => Text("Error, $error"),
                          loading: () => CircularProgressIndicator(),
                      )
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    height: 80,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: warrantyCount.when(
                          data: (data) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Warranties",
                                style: GoogleFonts.martianMono(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                data.toString(),
                                style: GoogleFonts.martianMono(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          error: (error,_) => Text("Error, $error"),
                          loading: () => CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Categories",
                style: GoogleFonts.montserratAlternates(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 16,
                  ),
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.computer,
                              size: 50,
                              color: Colors.black26,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Electronics",
                              style: GoogleFonts.montserratAlternates(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 5),
                            electronicsCount.when(
                                data: (data) => Text(
                                  "${data.toString()} Items",
                                  style: GoogleFonts.martianMono(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                error: (error, _) => Text("Error, $error"),
                                loading: () => CircularProgressIndicator(),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyAssetsPage(categoryName: "Electronics"),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.microwave,
                              size: 50,
                              color: Colors.black26,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Appliances",
                              style: GoogleFonts.montserratAlternates(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 5),
                            appliancesCount.when(
                              data: (data) => Text(
                                "${data.toString()} Items",
                                style: GoogleFonts.martianMono(
                                  color: Colors.grey[700],
                                ),
                              ),
                              error: (error, _) => Text("Error, $error"),
                              loading: () => CircularProgressIndicator(),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyAssetsPage(categoryName: "Appliances"),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chair, size: 50, color: Colors.black26),
                            SizedBox(height: 8),
                            Text(
                              "Furniture",
                              style: GoogleFonts.montserratAlternates(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 5),
                            furnitureCount.when(
                              data: (data) => Text(
                                "${data.toString()} Items",
                                style: GoogleFonts.martianMono(
                                  color: Colors.grey[700],
                                ),
                              ),
                              error: (error, _) => Text("Error, $error"),
                              loading: () => CircularProgressIndicator(),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyAssetsPage(categoryName: "Furniture"),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.pink[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.description_outlined,
                              size: 50,
                              color: Colors.black26,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Documents",
                              style: GoogleFonts.montserratAlternates(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 5),
                            documentCount.when(
                              data: (data) => Text(
                                "${data.toString()} Items",
                                style: GoogleFonts.martianMono(
                                  color: Colors.grey[700],
                                ),
                              ),
                              error: (error, _) => Text("Error, $error"),
                              loading: () => CircularProgressIndicator(),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyAssetsPage(categoryName: "Documents"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
