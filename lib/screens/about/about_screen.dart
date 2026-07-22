import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "PostureSense helps users detect Forward Head Posture using AI Pose Detection.\n\n"
          "Developed using Flutter, Firebase and Google ML Kit.\n\n"
          "Version 1.0.0",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}