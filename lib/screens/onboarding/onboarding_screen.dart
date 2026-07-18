import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Welcome"),
      ),

      body: Center(

        child: Padding(
          padding: EdgeInsets.all(20),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Icon(
                Icons.health_and_safety,
                size:120,
              ),

              SizedBox(height:30),

              Text(
                "Welcome to PostureSense",
                style: TextStyle(
                  fontSize:28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height:20),

              Text(
                "AI Powered Posture Monitoring App",
                textAlign: TextAlign.center,
              ),

              SizedBox(height:40),

              ElevatedButton(

onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ),
  );
},

                child: Text("Get Started"),

              ),

            ],
          ),
        ),
      ),
    );
  }
}