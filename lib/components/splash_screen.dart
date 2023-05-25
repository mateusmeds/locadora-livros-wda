import 'dart:async';

import 'package:flutter/material.dart';
import 'package:livraria_wda/components/home.dart';
import 'package:livraria_wda/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.blue),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 450,
                child: Image.asset('assets/wda_livraria.png'),
              ),
              Column(
                children: const [
                  Text('from', style: TextStyle(color: Colors.black38)),
                  SizedBox(height: 5),
                  Text(
                    'Mateus Medeiros',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
