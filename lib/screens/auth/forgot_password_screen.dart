import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {

  final emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    final result = await AuthService().resetPassword(
      emailController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Password reset email sent.",
          ),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Reset Password"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Form(

          key: formKey,

          child: Column(

            children: [

              const SizedBox(height: 40),

              const Icon(
                Icons.lock_reset,
                size: 90,
                color: Colors.orange,
              ),

              const SizedBox(height: 40),

              CustomTextField(
                controller: emailController,
                hint: "Email",
                icon: Icons.email,
              ),

              const SizedBox(height: 30),

              PrimaryButton(
                text: "SEND EMAIL",
                loading: loading,
                onPressed: resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}