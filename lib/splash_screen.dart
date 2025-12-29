import 'package:Trove/pages/logInPage.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    //controller initialization
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
    //logo scale animation
    _scale = Tween<double>(begin: 0.9,end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    //logo fade animation
    _opacity = Tween<double>(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    //start animation
    _controller.forward();
    //move to next screen
    _controller.addStatusListener((status){
      if(status == AnimationStatus.completed){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginPage(),));
      }
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
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //glow and logo
            FadeTransition(
                opacity: _opacity,
                child: ScaleTransition(
                    scale: _scale,
                    child: AnimatedContainer(
                        padding: EdgeInsets.all(20),
                        duration: Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.4 * _controller.value),
                              blurRadius: 50,spreadRadius: 15
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'lib/assets/images/LogoAndName.png',
                          width: 320,fit: BoxFit.contain,errorBuilder: (context, error, stackTrace) => Text("image not found"),
                        ),
                    ),
                ),
            ),

            SizedBox(height: 80,),

            //linearprogress indicator
            SizedBox(
              width: 300,
              child: LinearProgressIndicator(
                minHeight: 2,
                backgroundColor: Colors.grey[800],
                color: Color(0xff063F43)
              ),
            )
          ],
        ),
      ),
    );
  }
}

