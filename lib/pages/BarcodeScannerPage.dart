import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Barcodescannerpage extends StatefulWidget {
  const Barcodescannerpage({super.key});

  @override
  State<Barcodescannerpage> createState() => _BarcodescannerpageState();
}

class _BarcodescannerpageState extends State<Barcodescannerpage> {
  late final MobileScannerController _controller;
  bool _isScanned = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffff2),
      appBar: AppBar(
        backgroundColor: const Color(0xfffffff2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Scan Barcode",
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
      body: MobileScanner(
        controller: _controller,
        onDetect: (capture) async {
          if (_isScanned) return;
          _isScanned = true;

          final code = capture.barcodes.first.rawValue;
          if (code == null) return;

          await _controller.stop();

          if (mounted) {
            Navigator.pop(context, code);
          }
        },
      ),
    );
  }
}
