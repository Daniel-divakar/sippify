import 'package:flutter/material.dart';
import 'package:sippify/page/app_main_screen.dart';
import 'package:sippify/widgets/common_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            // Background Image
            SizedBox(
              height: size.height / 1.3,
              child: Image.asset(
                "assets/coffee-shop/bg.png",
                fit: BoxFit.cover,
                width: size.width,
                semanticLabel: 'Coffee Shop Background',
              ),
            ),
            // Bottom Content
            Positioned(
              bottom: 45,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animated Title Text
                    const AnimatedOpacity(
                      duration: Duration(seconds: 2),
                      opacity: 1.0,
                      child: Text(
                        "Fall in Love with Coffee in Blissful Delight!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Subtitle Text
                    Text(
                      "Welcome to our cozy coffee corner, where every cup is a delight for you.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Get Started Button
                    CommonButton(
                      title: "Get Started",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CoffeeAppMainScreen()),
                        );
                      },
                      buttonColor: Colors.brown,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
