import 'dart:async';
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
  bool showTagline = false;

  Timer? _typingTimer;
  bool _cursorVisible = true;
  Timer? _cursorBlinkTimer;

  void startTypeWriter() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 180), (timer) {
      if (index < fullText.length) {
        setState(() {
          displayText += fullText[index];
          index++;

          // Show tagline after 3 letters
          if (index >= 3 && !showTagline) {
            showTagline = true;
          }
        });
      } else {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) {
            setState(() {
              showLoader = true;
            });
          }
        });
        // Navigate to login page
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const loginPage()),
          );
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Controller initialization
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Logo scale animation - SIMPLIFIED
    _scale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    // Logo opacity animation
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
      ),
    );

    // Start animations
    _controller.forward();

    // Start typewriter
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        startTypeWriter();
      }
    });

    // Start cursor blink
    _cursorBlinkTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _cursorVisible = !_cursorVisible;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _typingTimer?.cancel();
    _cursorBlinkTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffff2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo with simple animations
                FadeTransition(
                  opacity: _opacity,
                  child: ScaleTransition(
                    scale: _scale,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'lib/assets/images/logo.png',
                          width: 110,
                          height: 110,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.workspace_premium, size: 50, color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Typewriter text with cursor
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      displayText,
                      style: GoogleFonts.martianMono(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),

                    // Blinking cursor
                    if (index < fullText.length && _cursorVisible)
                      Container(
                        width: 2,
                        height: 40,
                        margin: const EdgeInsets.only(left: 4),
                        color: Colors.blueAccent,
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // Tagline with simple fade
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: showTagline ? 1.0 : 0.0,
                  child: Text(
                    "Your Personal Asset Vault",
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Loading indicator (only when showLoader is true)
                if (showLoader)
                  Column(
                    children: [
                      // Simple progress bar
                      SizedBox(
                        width: 100,
                        child: LinearProgressIndicator(
                          minHeight: 2,
                          backgroundColor: Colors.grey[300],
                          color: Colors.blueAccent,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Loading...",
                        style: GoogleFonts.montserratAlternates(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}