//Flutter Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital/constants/resources.dart';
import 'package:hospital/globals/user_details.dart';
import 'package:hospital/screens/homepage.dart';
import 'package:hospital/theme/app_theme.dart';
import 'package:get/get.dart';
import 'log_in_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  goToNext() {
    Future.delayed(Duration(seconds: 3)).whenComplete(() =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LogInScreen()),
            (route) => false));
  }

  checkUserStatus() async {
    Future.delayed(Duration(seconds: 3)).whenComplete(() {
      User user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        currentUser = user;
        Get.offAll(HomePage());
      } else {
        Get.offAll(LogInScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Image.asset(logoJPEG),
      ),
    );
  }
}
