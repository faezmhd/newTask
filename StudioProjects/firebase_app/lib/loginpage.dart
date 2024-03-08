import 'package:flutter/material.dart';
import 'package:firebase_app/ImagePicker.dart';
import 'package:firebase_app/utils/custom_Textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'MyhomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  loginAuthenticate(email, password, BuildContext context) async {
    try {
      var ref = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (ref.user != null) {
        print("login success");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ImgPicker()),
        );
      } else {
        print("login failed");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid email or password"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Authentication Error: ${e.code}"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Login", style: TextStyle(color: Colors.orange)),
        iconTheme: const IconThemeData(color: Colors.orange), // Change the arrow color to orange
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(hint: "Email", controller: emailController),
            const SizedBox(height: 20),
            CustomTextField(hint: "Password", controller: passController),
            const SizedBox(height: 20),
            SizedBox(
              width: screenWidth * 0.6, // Adjust button width based on screen width
              child: ElevatedButton(
                onPressed: () {
                  loginAuthenticate(emailController.text, passController.text, context);
                },
                child: const Text("Login"),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
              child: const Text("Register here"),
            ),
          ],
        ),
      ),
    );
  }
}
