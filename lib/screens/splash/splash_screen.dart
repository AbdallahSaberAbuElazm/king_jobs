import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_jobs/config/util/hive_boxes.dart';
import 'package:king_jobs/screens/splash/define_user/define_user_screen.dart';
import 'package:king_jobs/screens/splash/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (HiveBoxes.getShowHome() == false) {
        Get.off(() => const OnboardingScreen());
      } else {
        Get.off(() => const DefineUserScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
