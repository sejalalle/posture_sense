import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    final auth = Provider.of<AuthProvider>(context, listen: false);

    final result = await auth.register(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account Created Successfully"),
          backgroundColor: Colors.green,
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
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 30),

              const Icon(
                Icons.person_add_alt_1,
                size: 90,
                color: Colors.blue,
              ),

              const SizedBox(height: 30),

             CustomTextField(
  controller: nameController,
  hint: "Full Name",
  icon: Icons.person,
),

              const SizedBox(height: 20),

CustomTextField(
  controller: emailController,
  hint: "Email",
  icon: Icons.email,
  isEmail: true,
),

              const SizedBox(height: 20),

            CustomTextField(
  controller: passwordController,
  hint: "Password",
  icon: Icons.lock,
  isPassword: true,
),
              const SizedBox(height: 35),

              PrimaryButton(
                text: "REGISTER",
                loading: auth.isLoading,
                onPressed: register,
              ),
            ],
          ),
        ),
      ),
    );
  }
}