import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:machine_test/core/componets/customtext.dart';
import 'package:machine_test/core/constants/color_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      context.go("/signin");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.pinkColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CustomText(
              data: 'Fliq Dating',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstants.primaryWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
