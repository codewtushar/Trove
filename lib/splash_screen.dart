import 'dart:async';
import 'dart:math';
import 'package:Trove/pages/logInPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;
  String displayText = "";
  final String fullText = "Trove";
  int index = 0;
  bool showLoader = false;

  void startTypeWritter() {
    Timer.periodic(Duration(milliseconds: 180), (timer) {
      if (index < fullText.length) {
        setState(() {
          displayText += fullText[index];
          index++;
        });
      } else {
        timer.cancel();
        Future.delayed(Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              showLoader = true;
            });
//Navigate to login page
            Future.delayed(Duration(milliseconds: 700),(){
              if(!mounted) return;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginPage(),));
            });
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
//controller initialization
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
//logo scale animation
    _scale = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//logo fade animation
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
//start animation
    _controller.forward();
//start typewriter
    WidgetsBinding.instance.addPostFrameCallback((_){
      startTypeWritter();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffff2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//glow and logo
            FadeTransition(
              opacity: _opacity,
              child: ScaleTransition(
                scale: _scale,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return AnimatedContainer(
                      padding: EdgeInsets.all(20),
                      duration: Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(
                              0.4 * _controller.value,
                            ),
                            blurRadius: 50,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(22),
                            child: Image.asset(
                              'lib/assets/images/logo.png',
                              width: 100,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Text("image not found"),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              displayText,
              style: GoogleFonts.martianMono(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            if (showLoader)
              Column(
                children: [
                  Text(
                    "Your Personal Asset Vault",
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),
                  ),

                  SizedBox(height: 40),

//linearprogress indicator
                  SizedBox(
                    width: 100,
                    child: LinearProgressIndicator(
                      minHeight: 2,
                      backgroundColor: Colors.blueGrey,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

