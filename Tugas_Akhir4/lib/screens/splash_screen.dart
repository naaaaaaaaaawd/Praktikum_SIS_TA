/*
  Muhamad Ridwan Pratama
  162024015
  Tugas Akhir 4
*/

import 'dart:async';
import 'package:challenge3/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToMainScreen();
  }

  void _goToMainScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/cafe.png',
          width: 150,
          height: 150,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.local_cafe,
            size: 100,
            color: Colors.brown,
          ),
        ),
      ),
    );
  }
}